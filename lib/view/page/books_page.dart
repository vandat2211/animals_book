import 'package:animals_book/resource/color.dart';
import 'package:animals_book/utils.dart';
import 'package:animals_book/view/page/Deltail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);
  static Route route() {
    return Utils.pageRouteBuilder(BooksPage(), false);
  }

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> with WidgetsBindingObserver {
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
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/logo.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 20, left: 20, right: 20),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: dataStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {}
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
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
                                    Navigator.of(context)
                                        .push<void>(
                                            DeltailPage.route(
                                                false,
                                                list_animal[index]['id'],
                                                list_animal[index]
                                                    ['url_dacdiem'],
                                                list_animal[index]
                                                    ['name_dacdiem'],
                                                list_animal[index]['describe']),
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
    );
  }
}
