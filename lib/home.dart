import 'package:flutter/material.dart';
import 'package:flutter_player/database/auth.dart';
import 'package:flutter_player/drawer.dart';
import 'package:flutter_player/footer.dart';
import 'package:flutter_player/music/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _supabase = Supabase.instance.client;
  List<Map<String, String>> tracks = []; 
  bool isPlaying = true;
  final TextEditingController _searchController = TextEditingController();
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    getTracks();
  }

  Future<void> getTracks() async {
    try {
      final response = await _supabase.from('track').select('name, author, image, musicUrl');
      
      
      setState(() {
        tracks = response.map((item) => {
          'name': item['name']?.toString() ?? 'Без названия',
          'author': item['author']?.toString() ?? 'Неизвестный исполнитель',
          'image': item['image']?.toString() ?? 'Без названия',
          'musicUrl': item['musicUrl']?.toString() ?? 'Неизвестный исполнитель',
        }).toList();
      });
      
      print('Загружено ${tracks.length} треков');
    } catch (e) {
      print('Ошибка загрузки треков: $e');
    }
  }

  List<Map<String, String>> get filteredTracks => tracks
    .where((track) =>
        track['name']!.toLowerCase().contains(_searchController.text.toLowerCase()))
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.blueGrey[600]),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.search, color: Colors.blueGrey[600]),
                    labelText: 'Поиск',
                    labelStyle: TextStyle(color: Colors.blueGrey[600]),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.white)
                    )
                  )
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Треки",
                  style: TextStyle(fontSize: 42),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
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
                            children: filteredTracks.map((track) {
                              return SizedBox(
                                width: (MediaQuery.of(context).size.width - 50) / 2, // 2 колонки
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        track['image']!,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        width: MediaQuery.of(context).size.width * 0.6,
                                      ),
                                    ),
                                    Text(
                                      track['name']!,
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      track['author']!,
                                      style: TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    FilledButton(onPressed: () {
                                        Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => PlayerPage(
                                            nameSound: track['name']!,
                                            author: track['author']!,
                                            urlMusic: track['musicUrl']!,
                                            urlPhoto: track['image']!,
                                          )
                                        )
                                      );
                                    }, child: Text("Прослушать"))

                                  ],
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
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Главная", style: TextStyle(color: Colors.white),),
        ),
        bottomNavigationBar: Footer(
          nameSound: 'Четыре сезона: Лето',
          author: 'Антонио Вивальди',
          urlMusic: 'https://rjnwjeopknvsrqsetrsf.supabase.co/storage/v1/object/public/storages/music/Yolanda_Kondonassis_Rudolf_Werthen_I_Fiamminghi_The_Orchestra_of_Flanders_Antonio_Vivaldi_-_Vivaldi_The_Four_Seasons_Violin_Concerto_in_G_Minor_Op_8_No_2_RV_315_Summer_-_I_Allegro_non_molto_Arr_Y_Kondonassis_R_Wer.mp3',
          urlPhoto: 'https://rjnwjeopknvsrqsetrsf.supabase.co/storage/v1/object/public/storages/music_photos/summer.png',
        ), 
        drawer: DrawerPage(),
      ),
    );
  }
}