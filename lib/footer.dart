import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Icon(Icons.music_note),
          title: Text("-------------------------------"),
          subtitle: Text('Название'),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow)),
        ),
      )
    );
  }
}