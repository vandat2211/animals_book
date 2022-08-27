import 'package:animals_book/Deltail_page.dart';
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
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('animal').snapshots();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                  height: 280,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/logo.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 20, left: 10, right: 10),
                child: StreamBuilder<QuerySnapshot>(
                    stream: dataStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {}
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final List list_animal = [];
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map a = document.data() as Map<String, dynamic>;
                        list_animal.add(a);
                        a['id'] = document.id;
                      }).toList();
                      return GridView.builder(
                          itemCount: list_animal.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DeltailPage(
                                              animalID: list_animal[index]
                                                  ['id'],
                                              url_dacdiem: list_animal[index]
                                                  ['url_dacdiem'],
                                              from_animal_page: false,
                                              name_dacdiem: list_animal[index]['name_dacdiem'],
                                            )),
                                  );
                                },
                                child: GridTile(
                                  footer: Material(
                                    color: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(8)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: GridTileBar(
                                      backgroundColor: Colors.black45,
                                      title: Text(
                                          '${list_animal[index]['name_dacdiem_el']}'),
                                      subtitle: Text(
                                          '${list_animal[index]['name_dacdiem']}'),
                                    ),
                                  ),
                                  child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.network(
                                        '${list_animal[index]['url_dacdiem']}',
                                        fit: BoxFit.cover,
                                      )),
                                ));
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
      ),
    );
  }
}
