import 'package:animals_book/animal_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/home_page.dart';
import 'package:animals_book/resource/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeltailPage extends StatefulWidget {
  bool from_animal_page;
  String animalID;
  String url_dacdiem;
  String name_dacdiem;
  DeltailPage(
      {Key? key,
      required this.animalID,
      required this.url_dacdiem,
      required this.from_animal_page,
      required this.name_dacdiem})
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
        .collection('food')
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
                      child: Image(
                        image: NetworkImage(widget.url_dacdiem),
                        fit: BoxFit.cover,
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
                        return GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listFood.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                            itemBuilder: (context, index) {
                              final Stream<QuerySnapshot> d = FirebaseFirestore
                                  .instance
                                  .collection('animal')
                                  .doc(widget.animalID)
                                  .collection('food')
                                  .doc(listFood[index]['id'])
                                  .collection('species')
                                  .snapshots();
                              return Padding(
                                padding: EdgeInsets.all(20.0),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: d,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {}
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      final List listSpecies = [];
                                      snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        Map a = document.data()
                                            as Map<String, dynamic>;
                                        listSpecies.add(a);
                                        a['id'] = document.id;
                                      }).toList();
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AnimalPage(
                                                      animalID: widget.animalID,
                                                      foodID: listFood[index]
                                                          ['id'],
                                                      loaiID:
                                                          listSpecies.isNotEmpty
                                                              ? listSpecies
                                                                  .first['id']
                                                              : 'a',
                                                      nameloai:
                                                          listSpecies.isNotEmpty
                                                              ? listSpecies
                                                                  .first['id']
                                                              : 'a',
                                                      url_dacdiem:
                                                          widget.url_dacdiem,
                                                      name_dacdiem:
                                                          widget.name_dacdiem,
                                                      name_food: listFood[index]
                                                          ['name_food'],
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: ExactAssetImage(
                                                  'assets/images/backgroundd.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '${listFood[index]['name_food']}')
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            });
                      }),
                ),
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 40),
                      child: Container(width:MediaQuery.of(context).size.width,color: Colors.white, child: Text("k")),
                    ))
              ],
            )),
      ),
    );
  }
}
