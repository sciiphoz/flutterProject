import 'package:flutter/material.dart';
import 'package:flutter_player/footer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final _supabase = Supabase.instance.client;
  List<Map<String, String>> tracks = []; 
  String searchQuery = '';
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
      final response = await _supabase.from('track').select('name, author');
      
      // Важно использовать setState для обновления интерфейса
      setState(() {
        tracks = response.map((item) => {
          'name': item['name']?.toString() ?? 'Без названия',
          'author': item['author']?.toString() ?? 'Неизвестный исполнитель',
        }).toList();
      });
      
      print('Загружено ${tracks.length} треков');
    } catch (e) {
      print('Ошибка загрузки треков: $e');
    }
  }

  List<Map<String, String>> get filteredTracks => tracks
      .where((track) =>
          track['author']!.toLowerCase().contains(searchQuery.toLowerCase()))
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
                  fillColor: Colors.white.withOpacity(0.2),
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
                    searchQuery = value;
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
                          children: tracks.map((track) {
                            return SizedBox(
                              width: (MediaQuery.of(context).size.width - 50) / 2, // 2 колонки
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: .3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.image, color: Colors.white, size: 40),
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
        bottomNavigationBar: Footer(),
      ),
    );
  }
}
