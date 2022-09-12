
import 'package:animals_book/utils.dart';
import 'package:animals_book/view/page/books_page.dart';
import 'package:animals_book/view/page/home_page.dart';
import 'package:animals_book/view/page/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPage extends StatefulWidget {
   AppPage({Key? key}) : super(key: key);
  static Route route() {
    return Utils.pageRouteBuilder(AppPage(), false);
  }
  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  String? name='';
  String? email='';
  String? user_url='';
  Future _getData()async{
    final prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot)async{
      if(snapshot.exists){
        name= snapshot.data()!["user_name"];
        email= snapshot.data()!["email"];
        user_url= snapshot.data()!["user_url"];
        await prefs.setString('name', name!);
        await prefs.setString('email', email!);
        await prefs.setString('user_url', user_url!);
      }
    });
  }
  int _currentIndex = 1;
  final tabs = [
     HomePage(),
     const BooksPage(),
     ProfilePage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index:_currentIndex,
        backgroundColor: Colors.lightBlue.shade100,
        color: Colors.green,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index){
          setState((){
            _currentIndex=index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.menu_book_sharp,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
