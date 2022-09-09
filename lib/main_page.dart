import 'package:animals_book/app_page.dart';
import 'package:animals_book/view/login/auth_page.dart';
import 'package:animals_book/view/page/books_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const AuthPage(
            );
          }
          else{
            return  AppPage();
          }
        },
      ) ,
    );
  }
}

