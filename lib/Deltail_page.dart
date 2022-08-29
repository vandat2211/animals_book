import 'package:animals_book/animal_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/home_page.dart';
import 'package:animals_book/resource/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DeltailPage extends StatefulWidget {
  bool from_animal_page;
  String animalID;
  String url_dacdiem;
  String name_dacdiem;
  String describe;
  DeltailPage(
      {Key? key,
      required this.animalID,
      required this.url_dacdiem,
      required this.from_animal_page,
      required this.name_dacdiem,
        required this.describe})
      : super(key: key);

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                Navigator.of(context).pop();
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
                            image:  DecorationImage(
                                image:
                                NetworkImage(widget.url_dacdiem),
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
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listFood.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 0.5,
                              ),
                              itemBuilder: (context, index) {
                                final Stream<QuerySnapshot> d = FirebaseFirestore
                                    .instance
                                    .collection('animal')
                                    .doc(widget.animalID)
                                    .collection('classify')
                                    .doc(listFood[index]['id'])
                                    .collection('species')
                                    .snapshots();
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.0,right: 20,bottom: 10),
                                  child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AnimalPage(
                                                        animalID: widget.animalID,
                                                        foodID: listFood[index]
                                                            ['id'],
                                                        loaiID: 'a',
                                                        nameloai: 'a',
                                                        url_dacdiem:
                                                            widget.url_dacdiem,
                                                        name_dacdiem:
                                                            widget.name_dacdiem,
                                                        name_classify: listFood[index]
                                                            ['name_classify'],
                                                        describe: widget.describe,
                                                        url_classify: listFood[index]['url_classify'],
                                                        describe_classify: listFood[index]['describe_classify'], describe_species: 'a', url_species: 'a', drawer: false, name_species: '',
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
                                              child: Container(
                                                height: MediaQuery.of(context).size.width * 0.08,
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
                                        )
                                );
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
                          )
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
