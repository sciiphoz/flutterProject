import 'package:flutter/material.dart';
import 'package:flutter_player/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegPage extends StatefulWidget 
{
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/icon.png'),
            Text(
              "Регистрация",
              textScaler: TextScaler.linear(3),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
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
                    controller: passwordController,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: repeatController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password, color: Colors.white),
                      labelText: 'Подтвердите пароль',
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
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(onPressed: () async {
                if (emailController.text.isEmpty || passwordController.text.isEmpty || repeatController.text.isEmpty) {
                  print("Поля пусты.");
                }
                else {
                  if (passwordController.text == repeatController.text) {
                    var user = await authService.signUp(emailController.text, passwordController.text);

                    if (user != null) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool("isLoggedIn", true);
                      Navigator.popAndPushNamed(context, '/'); 
                    }
                  }
                  else { print("Пароли не совпадают."); }
                }
              }, 
              child: Text("Создать аккаунт"),), 
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: OutlinedButton(onPressed: (){
                Navigator.popAndPushNamed(context, '/');
              }, child: Text("Войти")),
            )
          ],
        ),
      ),
    );
  }
}