import 'package:animals_book/Deltail_page.dart';
import 'package:animals_book/animal_deltail_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/get_l.dart';
import 'package:animals_book/get_loai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimalPage extends StatefulWidget {
  String animalID;
  String dtID;
  String loaiID;
  String nameloai;

  AnimalPage({Key? key, required this.animalID, required this.dtID,required this.loaiID,required this.nameloai})
      : super(key: key);

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  List<String> docIDs = [];
  List<String> loaiIDs = [];
  Future getloai() async {
    await FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('dactinh')
        .doc(widget.dtID)
        .collection('loai')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              loaiIDs.add(document.reference.id);
            }));
  }

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('dactinh')
        .doc(widget.dtID)
        .collection('loai')
        .doc(widget.loaiID)
        .collection(widget.nameloai)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          context,
          title: const Text("Dong vat an thit"),
          showDefaultBackButton: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroundd.jpg'),
                    fit: BoxFit.cover)),
          ),
          leading: IconButton(onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (
                context) =>  DeltailPage(animalID: widget.animalID,)),
          ); }, icon: Icon(Icons.arrow_back),),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 50, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image:
                                      ExactAssetImage('assets/images/logo.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          height: 200,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: FutureBuilder(
                      future: getDocID(),
                      builder: (context, snapshot) {
                        return GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: docIDs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AnimalDeltailPage()),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: ExactAssetImage(
                                              'assets/images/backgroundd.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GetLoai(
                                            animalID: widget.animalID,
                                            ddid: widget.dtID,
                                            loaiid: docIDs[index], namelaoi: widget.nameloai)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            )),
        endDrawer: Drawer(
          child: SafeArea(
            child: FutureBuilder(
                future: getloai(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: loaiIDs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.access_time_filled),
                          title: GetL(animalID: widget.animalID, ddid: widget.dtID, loaiid: loaiIDs[index]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  AnimalPage(animalID:widget.animalID, dtID: widget.dtID, loaiID: loaiIDs[index], nameloai: GetL(animalID: widget.animalID, ddid: widget.dtID, loaiid: loaiIDs[index]).toString(),)),
                            );
                          },
                        );
                      }
                      );
                }),
          ),
        ));
  }
}
