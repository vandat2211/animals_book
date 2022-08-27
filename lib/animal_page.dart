import 'package:animals_book/Deltail_page.dart';
import 'package:animals_book/animal_deltail_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/model/species.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimalPage extends StatefulWidget {
  String animalID;
  String foodID;
  String loaiID;
  String nameloai;
  String url_dacdiem;
  String name_dacdiem;
  String name_food;

  AnimalPage(
      {Key? key,
      required this.animalID,
      required this.foodID,
      required this.loaiID,
      required this.nameloai,
      required this.url_dacdiem,
        required this.name_dacdiem,required this.name_food})
      : super(key: key);

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream1 = FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('food')
        .doc(widget.foodID)
        .collection('species')
        .snapshots();
    final Stream<QuerySnapshot> dataStream2 = FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('food')
        .doc(widget.foodID)
        .collection('species')
        .doc(widget.loaiID)
        .collection(widget.nameloai)
        .snapshots();
    return Scaffold(
        appBar: CustomAppBar(
          context,
          title:  Text(widget.name_dacdiem+'(${widget.name_food.toLowerCase()})',style: TextStyle(fontSize: 18),),
          showDefaultBackButton: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroundd.jpg'),
                    fit: BoxFit.cover)),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeltailPage(
                          animalID: widget.animalID,
                          url_dacdiem: widget.url_dacdiem, from_animal_page: true, name_dacdiem: widget.name_dacdiem,
                        )),
              );
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: dataStream2,
                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.hasError){

                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final List docIDs=[];
                        snapshot.data!.docs.map((DocumentSnapshot document){
                          Map a=document.data() as Map<String,dynamic>;
                          docIDs.add(a);
                          a['id']=document.id;
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
                                    Text('${docIDs[index]['name_animal']}')
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
            child: StreamBuilder<QuerySnapshot>(
                stream: dataStream1,
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasError){

                  }
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List list_species=[];
                  snapshot.data!.docs.map((DocumentSnapshot document){
                    Map a=document.data() as Map<String,dynamic>;
                    list_species.add(a);
                    a['id']=document.id;
                  }).toList();
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: list_species.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.access_time_filled),
                          title: Text('${list_species[index]['name_species']}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimalPage(
                                      animalID: widget.animalID,
                                      foodID: widget.foodID,
                                      loaiID: list_species[index]['id'],
                                      nameloai: list_species[index]['id'],
                                    url_dacdiem: widget.url_dacdiem,
                                    name_dacdiem: widget.name_dacdiem, name_food: widget.name_food,)),
                            );
                          },
                        );
                      });
                }),
          ),
        ));
  }
}
