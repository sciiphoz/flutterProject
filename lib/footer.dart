import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/music/player.dart';

class Footer extends StatefulWidget {
  String? urlMusic;
  String? urlPhoto;
  String? nameSound;
  String? author;
  Footer({
    super.key,
    this.urlMusic,
    this.urlPhoto,
    this.nameSound,
    this.author,
  });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String? _urlMusic;
  String? _urlPhoto;
  String? _nameSound;
  String? _author;
  bool isPlaying = false;
  late final AudioPlayer audioPlayer;
  late final UrlSource urlSource;
  Duration _duration = Duration();
  Duration _position = Duration();

  Future initPlayer() async {
    audioPlayer = AudioPlayer();

    urlSource = UrlSource(_urlMusic!);

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    /// Позиция песни
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
    // Чтобы завершалась
    audioPlayer.onPlayerComplete.listen((comleted) {
      setState(() {
        _position = _duration;
        // isPlaying = !isPlaying;
      });
    });
  }

  void playPause() async {
    if (isPlaying) {
      audioPlayer.pause();
      isPlaying = false;
    } else {
      audioPlayer.play(urlSource);
      isPlaying = true;
    }
    setState(() {});
  }

  // Инициализация
  @override
  void initState() {
    _urlPhoto = widget.urlPhoto;
    _urlMusic = widget.urlMusic;
    _author = widget.author;
    _nameSound = widget.nameSound;
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: MediaQuery.of(context).size.height * 0.2,
    //   padding: EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //     color: Colors.blueGrey.shade700,
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: ListTile(
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           CupertinoPageRoute(
    //             builder: (context) => PlayerPage(
    //               nameSound: _nameSound,
    //               author: _nameSound,
    //               urlMusic: _urlMusic,
    //               urlPhoto: _urlMusic,
    //             )
    //           )
    //         );
    //       },
    //       leading: Image.network(
    //           _urlPhoto!,
    //           height: MediaQuery.of(context).size.height * 0.2,
    //           width: MediaQuery.of(context).size.width * 0.2,
    //         ),
    //       title: Slider(
    //           min: 0,
    //           max: _duration.inSeconds.toDouble(),
    //           activeColor: Colors.blue,
    //           inactiveColor: Colors.white,
    //           value: _position.inSeconds.toDouble(),
    //           onChanged: (value) async {
    //             await audioPlayer.seek(Duration(seconds: value.toInt()));
    //             setState(() {});
    //           },
    //         ),
    //       subtitle: Text(_nameSound!),
    //       trailing: IconButton(
    //         color: Colors.white,
    //         onPressed: playPause,
    //         icon:
    //             isPlaying
    //                 ? Icon(Icons.pause_circle, size: 60)
    //                 : Icon(Icons.play_circle, size: 60),
    //       ),
    //     ),
    //   )
    // );
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => PlayerPage(
                  nameSound: _nameSound,
                  author: _nameSound,
                  urlMusic: _urlMusic,
                  urlPhoto: _urlPhoto,
                )
              )
            );
          },
          leading: Image.network(
              _urlPhoto!,
            ),
          title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
            child: Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                activeColor: Colors.blue,
                inactiveColor: Colors.white,
                value: _position.inSeconds.toDouble(),
                onChanged: (value) async {
                  await audioPlayer.seek(Duration(seconds: value.toInt()));
                  setState(() {});
                },
              ),
          ),
          subtitle: Text(_nameSound!),
          trailing: IconButton(
            color: Colors.white,
            onPressed: playPause,
            icon:
                isPlaying
                    ? Icon(Icons.pause_circle, size: MediaQuery.of(context).size.height * 0.04,)
                    : Icon(Icons.play_circle, size: MediaQuery.of(context).size.height * 0.04,),
          ),
        ),
      )
    );

  }
}

extension on Duration {
  String format(Duration duration) {
    String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String seconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds";
  }
}