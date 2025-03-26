import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/footer.dart';
import 'package:flutter_player/music/player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final _supabase = Supabase.instance.client;
  List<Map<String, String>> tracks = []; 
  int currentTrackIndex = 0;
  bool isPlaying = true;
  TextEditingController _searchController = TextEditingController();

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
          track['author']!.toLowerCase().contains(_searchController.text.toLowerCase()))
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
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.2),
                  hintText: 'Поиск по названию или исполнителю',
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
                  setState(() {
                  });
                },
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
