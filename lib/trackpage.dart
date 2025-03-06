import 'package:flutter/material.dart';
import 'package:flutter_player/footer.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  bool isPlaying = true;


  final List<Map<String, String>> tracks = [
    {'title': 'Название трека 1', 'author': 'Исполнитель 1'},
    {'title': 'Название трека 2', 'author': 'Исполнитель 2'},
    {'title': 'Название трека 3', 'author': 'Исполнитель 3'},
    {'title': 'Название трека 4', 'author': 'Исполнитель 4'},
    {'title': 'Название трека 5', 'author': 'Исполнитель 5'},
  ];


  int currentTrackIndex = 0;

  void nextTrack() {
    setState(() {
      if (currentTrackIndex < tracks.length - 1) {
        currentTrackIndex++;
      } else {
        currentTrackIndex = 0;
      }
    });
  }

  void previousTrack() {
    setState(() {
      if (currentTrackIndex > 0) {
        currentTrackIndex--;
      } else {
        currentTrackIndex = tracks.length - 1; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Название плейлиста', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.music_note,
                size: 100,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
           
            Text(
              tracks[currentTrackIndex]['title']!,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              tracks[currentTrackIndex]['author']!,
              style: TextStyle(fontSize: 16, color: Colors.white.withValues(alpha: 0.5),),
            ),
            SizedBox(height: 20),
        
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: LinearProgressIndicator(
                value: 0.5, 
                backgroundColor: Colors.white.withValues(alpha: .3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousTrack,
                  icon: Icon(Icons.skip_previous, color: Colors.white, size: 40),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () => setState(() => isPlaying = !isPlaying),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                IconButton(
                  onPressed: nextTrack,
                  icon: Icon(Icons.skip_next, color: Colors.white, size: 40),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}