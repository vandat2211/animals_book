import 'package:animals_book/app_page.dart';
import 'package:animals_book/view/page/animal_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/view/page/books_page.dart';
import 'package:animals_book/resource/color.dart';
import 'package:animals_book/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DeltailPage extends StatefulWidget {
  bool from_animal_page;
  String animalID;
  String url_dacdiem;
  String name_dacdiem;
  String describe;
  DeltailPage.init(
      {Key? key,
      required this.animalID,
      required this.url_dacdiem,
      required this.from_animal_page,
      required this.name_dacdiem,
      required this.describe})
      : super(key: key);
  static Route route(bool from_animal_page, String animalID, String url_dacdiem,
      String name_dacdiem, String describe) {
    return Utils.pageRouteBuilder(
        DeltailPage.init(
          name_dacdiem: name_dacdiem,
          describe: describe,
          animalID: animalID,
          url_dacdiem: url_dacdiem,
          from_animal_page: from_animal_page,
        ),
        true);
  }

  @override
  State<DeltailPage> createState() => _DeltailPageState();
}

class _DeltailPageState extends State<DeltailPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('classify')
        .snapshots();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          title: Text(widget.name_dacdiem),
          showDefaultBackButton: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroundd.jpg'),
                    fit: BoxFit.cover)),
          ),
          leading: IconButton(
            onPressed: () {
              if (widget.from_animal_page == true) {
                Navigator.of(context).pushAndRemoveUntil<void>(
                    AppPage.route(), (route) => false);
              } else {
                // Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil<void>(
                    AppPage.route(), (route) => false);
              }
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
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.url_dacdiem),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: dataStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {}
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final List listFood = [];
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map a = document.data() as Map<String, dynamic>;
                          listFood.add(a);
                          a['id'] = document.id;
                        }).toList();
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFood.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 0.5,
                              ),
                              itemBuilder: (context, index) {
                                final Stream<QuerySnapshot> d =
                                    FirebaseFirestore.instance
                                        .collection('animal')
                                        .doc(widget.animalID)
                                        .collection('classify')
                                        .doc(listFood[index]['id'])
                                        .collection('species')
                                        .snapshots();
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 20, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil<void>(
                                                AnimalPage.route(
                                                    widget.animalID,
                                                    listFood[index]['id'],
                                                    'a',
                                                    'a',
                                                    widget.url_dacdiem,
                                                    widget.name_dacdiem,
                                                    listFood[index]
                                                        ['name_classify'],
                                                    widget.describe,
                                                    listFood[index]
                                                    ['describe_classify'],
                                                    listFood[index]
                                                        ['url_classify'],
                                                    'a',
                                                    'a',
                                                    false,
                                                    ''),
                                                (route) => false);
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
                                                0.08,
                                            child: GridTileBar(
                                              backgroundColor: Colors.black45,
                                              title: Text(
                                                  '${listFood[index]['name_classify']}'),
                                            ),
                                          ),
                                        ),
                                        child: Material(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.network(
                                              '${listFood[index]['url_classify']}',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ));
                              }),
                        );
                      }),
                ),
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 40),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Html(
                              data: widget.describe,
                              style: {
                                "#": Style(
                                    textAlign: TextAlign.left,
                                    fontSize: const FontSize(12),
                                    fontFamily: "Roboto",
                                    lineHeight: const LineHeight(1.5))
                              },
                            ),
                          )),
                    ))
              ],
            )),
      ),
    );
  }
}
