import 'package:animals_book/Deltail_page.dart';
import 'package:animals_book/get_dacdiem.dart';
import 'package:animals_book/model/animal.dart';
import 'package:animals_book/resource/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<String> list_animal = [];
  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('animal')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              list_animal.add(document.reference.id);
            }));
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // làm trong suốt statusbar
      statusBarIconBrightness: Brightness.light, // icon statusbar màu trắng
    ));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: ExactAssetImage('assets/images/background.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            children: [
                    Container(
                        height: 280,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/images/logo.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                              future: getDocID(),
                              builder: (context, snapshot) {
                                return GridView.builder(
                                    itemCount: list_animal.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      mainAxisExtent: 120,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeltailPage(
                                                          animalID:
                                                              list_animal[index],
                                                        )),
                                              );
                                            },
                                            child: GetDacDiem(animalId: list_animal[index],)
                                            ),
                                      );
                                    });
                              }),
                        )),
                  ],
                ),
              ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.lightBlue.shade100,
          color: Colors.green,
          animationDuration: const Duration(milliseconds: 200),
          items: const [
          Icon(Icons.home,color: Colors.white,),
          Icon(Icons.menu_book_sharp,color: Colors.white,),
          Icon(Icons.person,color: Colors.white,),
        ],),
      ),
    );
  }
}
