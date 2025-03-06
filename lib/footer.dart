import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){ Navigator.popAndPushNamed(context, '/main'); }, icon: Icon(Icons.home, color: Colors.white, size: 40,)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            IconButton(onPressed: (){ Navigator.popAndPushNamed(context, '/track'); }, icon: Icon(CupertinoIcons.music_note, color: Colors.white, size: 40,)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            IconButton(onPressed: (){ Navigator.popAndPushNamed(context, '/playlists'); }, icon: Icon(CupertinoIcons.music_albums, color: Colors.white, size: 40,)),
          ],
        ),
    );
  }
}