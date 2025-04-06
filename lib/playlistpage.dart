import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/footer.dart';
import 'package:flutter_player/list.dart';
import 'package:flutter_player/database/users_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Map<String, String>> lists = []; 
  bool isPlaying = true;
  UsersTable usersTable = UsersTable();

  final _supabase = Supabase.instance.client;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newPlaylistController = TextEditingController();
  final String currentUser = Supabase.instance.client.auth.currentUser!.id.toString();

  @override
  void initState() {
    super.initState();
    getLists();
  }

  Future<void> getLists() async {
    try {
      final response = await _supabase.from('list').select('id, list_name, user_id')
      .eq('user_id', currentUser);
      
      setState(() {
        lists = response.map((item) => {
          'id':item['id']?.toString() ?? "",
          'list_name': item['list_name']?.toString() ?? 'Без названия',
          'user_id': item['user_id']?.toString() ?? 'Неизвестный исполнитель',
        }).toList();
      });
      
      print('Загружено ${lists.length} треков');
    } catch (e) {
      print('Ошибка загрузки треков: $e');
    }
  }

  void _showAddPlaylistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Новый плейлист'),
          content: TextField(
            controller: _newPlaylistController,
            decoration: InputDecoration(
              hintText: 'Введите название плейлиста',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Создать'),
              onPressed: () {
                usersTable.addUserList(_newPlaylistController.text, currentUser);
                getLists();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  List<Map<String, String>> get filteredLists => lists
      .where((list) =>
          list['list_name']!.toLowerCase().contains(_searchController.text.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.blueGrey]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Ваши плейлисты', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        hintText: 'Поиск по названию',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: _showAddPlaylistDialog,
                    ),
                  ),
                ],
              ),
            ),
            // Основной контент
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 80), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: filteredLists.map((list) {
                            return SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(200, 0, 200, 0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.3),
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          list['list_name']!,
                                          style: TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            FilledButton(onPressed: () {
                                                Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) => ListPage(
                                                    id_list: list['id']
                                                  )
                                                )
                                              );
                                            }, child: Text("Прослушать")),
                                            IconButton(onPressed: () {
                                              usersTable.deleteUserList(list['id']!);
                                              getLists();
                                              // Navigator.of(context).pop();
                                            }, icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),    
            SizedBox(height: 20), 
          ],
        ),
        bottomNavigationBar: Footer(
          nameSound: 'Четыре сезона: Лето',
          author: 'Антонио Вивальди',
          urlMusic: 'https://rjnwjeopknvsrqsetrsf.supabase.co/storage/v1/object/public/storages/music/Yolanda_Kondonassis_Rudolf_Werthen_I_Fiamminghi_The_Orchestra_of_Flanders_Antonio_Vivaldi_-_Vivaldi_The_Four_Seasons_Violin_Concerto_in_G_Minor_Op_8_No_2_RV_315_Summer_-_I_Allegro_non_molto_Arr_Y_Kondonassis_R_Wer.mp3',
          urlPhoto: 'https://rjnwjeopknvsrqsetrsf.supabase.co/storage/v1/object/public/storages/music_photos/summer.png',
        ),
      ),
    );
  }
}
