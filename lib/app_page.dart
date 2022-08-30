
import 'package:animals_book/utils.dart';
import 'package:animals_book/view/page/books_page.dart';
import 'package:animals_book/view/page/home_page.dart';
import 'package:animals_book/view/page/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);
  static Route route() {
    return Utils.pageRouteBuilder(AppPage(), false);
  }

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 1;
  final tabs = [
    const HomePage(),
    const BooksPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
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
