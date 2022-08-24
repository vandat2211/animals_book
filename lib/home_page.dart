import 'package:animals_book/Deltail_page.dart';
import 'package:animals_book/get_dacdiem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<String> docIDs=[];
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('animal').get().then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference);
      docIDs.add(document.reference.id);
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 360,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/backgroundd.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0))),
                margin: const EdgeInsets.only(top: 80, left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      height: 420,
                      child: FutureBuilder(
                        future: getDocID(),
                        builder: (context,snapshot) {
                          return
                          GridView.builder(
                              itemCount: docIDs.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 120,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (
                                            context) =>  DeltailPage(animalID: docIDs[index],)),
                                      );
                                    },
                                    child: GetDacDiem(animalId: docIDs[index],)
                                  ),
                                );
                              });
                        }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
