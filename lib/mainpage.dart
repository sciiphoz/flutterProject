import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(        
        color: Colors.blueGrey[600],
        child: Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: Colors.white, size: 40,)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward, color: Colors.white, size: 40,)),
          ],
        ),
      ),
    );
  }
}