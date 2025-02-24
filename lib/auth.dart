import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget 
{
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/icon.png'),
            Text(
              "Вход",
              textScaler: TextScaler.linear(3),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column( 
                children: [
                  TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.white)
                      )
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password, color: Colors.white),
                      labelText: 'Пароль',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.white)
                      )
                    ),
                  ),
                ]
              )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.centerRight,
              child: InkWell(
                child: Text("Забыли пароль?",),
                onTap: (){ Navigator.popAndPushNamed(context, '/recovery'); },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(onPressed: (){ Navigator.popAndPushNamed(context, '/main'); }, child: Text("Войти"),), 
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: OutlinedButton(onPressed: (){
                Navigator.popAndPushNamed(context, '/reg');
              }, child: Text("Зарегистрироваться")),
            )
          ],
        ),
      ),
    );
  }
}