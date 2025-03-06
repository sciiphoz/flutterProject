import 'package:flutter/material.dart';
import 'package:flutter_player/database/auth.dart';
import 'package:flutter_player/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  final List<Map<String, String>> playlists = [
    {'title': 'Плейлист 1'},
    {'title': 'Плейлист 2'},
    {'title': 'Плейлист 3'},
    {'title': 'Плейлист 4'},
    {'title': 'Плейлист 5'},
    {'title': 'Плейлист 6'},
  ];

  final List<Map<String, String>> artists = [
    {'name': 'Исполнитель 1'},
    {'name': 'Исполнитель 2'},
    {'name': 'Исполнитель 3'},
    {'name': 'Исполнитель 4'},
    {'name': 'Исполнитель 5'},
  ];

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
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
                "Плейлисты",
                style: TextStyle(fontSize: 42),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: () async {
            await authService.logOut();
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            Navigator.popAndPushNamed(context, '/auth');
          }, icon: Icon(Icons.logout, color: Colors.white,))
        ],
      ),
      bottomNavigationBar: const Footer(), 
    );
  }
}