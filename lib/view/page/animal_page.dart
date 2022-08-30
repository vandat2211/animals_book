import 'package:animals_book/view/page/Deltail_page.dart';
import 'package:animals_book/view/page/animal_deltail_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/resource/assets.dart';
import 'package:animals_book/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimalPage extends StatefulWidget {
  String animalID;
  String foodID;
  String loaiID;
  String nameloai;
  String url_dacdiem;
  String name_dacdiem;
  String name_classify;
  String describe;
  String describe_classify;
  String url_classify;
  String url_species;
  String describe_species;
  bool drawer;
  String name_species;

  AnimalPage.init(
      {Key? key,
      required this.animalID,
      required this.foodID,
      required this.loaiID,
      required this.nameloai,
      required this.url_dacdiem,
      required this.name_dacdiem,
      required this.name_classify,
      required this.describe,
      required this.describe_classify,
      required this.url_classify,
      required this.describe_species,
      required this.url_species,
      required this.drawer,
      required this.name_species})
      : super(key: key);
  static Route route(
  String animalID,
  String foodID,
  String loaiID,
  String nameloai,
  String url_dacdiem,
  String name_dacdiem,
  String name_classify,
  String describe,
  String describe_classify,
  String url_classify,
  String url_species,
  String describe_species,
  bool drawer,
  String name_species,) {
    return Utils.pageRouteBuilder(
        AnimalPage.init(
          describe_classify: describe_classify,
          name_species: name_species,
          describe: describe,
          url_dacdiem: url_dacdiem,
          loaiID: loaiID,
          animalID: animalID,
          url_classify: url_classify,
          name_classify: name_classify,
          nameloai: nameloai,
          drawer: drawer,
          url_species: url_species,
          name_dacdiem: name_dacdiem,
          foodID: foodID,
          describe_species: describe_species,
        ),
        true);
  }

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  int _currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream1 = FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('classify')
        .doc(widget.foodID)
        .collection('species')
        .snapshots();
    final Stream<QuerySnapshot> dataStream2 = FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('classify')
        .doc(widget.foodID)
        .collection('species')
        .doc(widget.loaiID)
        .collection(widget.nameloai)
        .snapshots();
    return Scaffold(
        appBar: CustomAppBar(
          context,
          title: widget.drawer
              ? Text(
                  widget.name_dacdiem +
                      '(${widget.name_species.toLowerCase()})',
                  style: TextStyle(fontSize: 18),
                )
              : Text(
                  widget.name_dacdiem +
                      '(${widget.name_classify.toLowerCase()})',
                  style: TextStyle(fontSize: 18),
                ),
          showDefaultBackButton: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroundd.jpg'),
                    fit: BoxFit.cover)),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil<void>(
                  DeltailPage.route(true, widget.animalID, widget.url_dacdiem,
                      widget.name_dacdiem, widget.describe),
                  (route) => false);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.drawer
                                          ? NetworkImage(widget.url_species)
                                          : NetworkImage(widget.url_classify),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: SingleChildScrollView(
                                child: Html(
                                  data: widget.drawer
                                      ? widget.describe_species
                                      : widget.describe_classify,
                                  style: {
                                    "#": Style(
                                        textAlign: TextAlign.left,
                                        fontSize: const FontSize(12),
                                        fontFamily: "Roboto",
                                        lineHeight: const LineHeight(1.5))
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: dataStream2,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final List docIDs = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map a = document.data() as Map<String, dynamic>;
                            docIDs.add(a);
                            a['id'] = document.id;
                          }).toList();
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: docIDs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AnimalDeltailPage()),
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
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.10,
                                            child: GridTileBar(
                                              backgroundColor: Colors.black45,
                                              title: docIDs[index]
                                                          ['name_animal_el'] ==
                                                      null
                                                  ? Text(
                                                      '${docIDs[index]['name_animal']}',
                                                      overflow:
                                                          TextOverflow.clip,
                                                    )
                                                  : Text(
                                                      '${docIDs[index]['name_animal_el']}',
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                              subtitle: Text(
                                                '${docIDs[index]['name_animal']}',
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Material(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.network(
                                              '${docIDs[index]['url_animal']}',
                                              fit: BoxFit.cover,
                                            )),
                                      )),
                                );
                              });
                        }),
                  )
                ],
              ),
            )),
        endDrawer: Drawer(
          child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: dataStream1,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {}
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List list_species = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    list_species.add(a);
                    a['id'] = document.id;
                  }).toList();
                  return Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: DrawerHeader(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.drawer
                                          ? NetworkImage(widget.url_species)
                                          : NetworkImage(widget.url_classify),
                                      fit: BoxFit.cover)),
                              child: Text(widget.name_classify),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: list_species.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Image.network(
                                    list_species[index]['icon_species']
                                        .toString(),
                                    width: 24,
                                    height: 24,
                                  ),
                                  title: Text(
                                      '${list_species[index]['name_species']}'),
                                  onTap: () async {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil<void>(
                                        AnimalPage.route(
                                            widget.animalID,
                                            widget.foodID,
                                            list_species[index]
                                            ['id'],
                                            list_species[index]
                                            ['id'],
                                            widget.url_dacdiem,
                                            widget.name_dacdiem,
                                            widget.name_classify,
                                            widget.describe,
                                            widget.describe_classify,
                                            widget.url_classify,
                                            list_species[index]
                                            ['url_species'],
                                            list_species[index]
                                            ['describe_species'],
                                            true,
                                            list_species[index]
                                            ['name_species']),
                                            (route) => false);
                                  },
                                );
                              })),
                    ],
                  );
                }),
          ),
        ));
  }
}
