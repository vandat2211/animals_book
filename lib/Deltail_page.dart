import 'package:animals_book/animal_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/get_dactinh.dart';
import 'package:animals_book/get_img.dart';
import 'package:animals_book/resource/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DeltailPage extends StatefulWidget {
  String animalID;
   DeltailPage({Key? key,required this.animalID}) : super(key: key);

  @override
  State<DeltailPage> createState() => _DeltailPageState();
}

class _DeltailPageState extends State<DeltailPage> {
  List<String> list_food=[];
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('animal').doc(widget.animalID).collection('food').get().then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference);
      list_food.add(document.reference.id);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(context,title:Text("tren can"),showDefaultBackButton: false,flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundd.jpg'),
              fit: BoxFit.cover
            )
          ),
        ),),
        body:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/backgroundd.jpg'),
                fit: BoxFit.cover
              ),
            ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15,left: 15,top: 40,bottom: 20),
                child: Container(
                  height: 200,
                  child: GetImg(animalId: widget.animalID,),
                ),
              ),
              SizedBox(
                height: 100,
                child: FutureBuilder(
                  future: getDocID(),
                  builder: (context,snapshot){
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: list_food.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 150,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  AnimalPage(animalID:widget.animalID, foodID: list_food[index], loaiID: '', nameloai: '',)),
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage('assets/images/backgroundd.jpg'),
                                  fit: BoxFit.cover,
                                ),),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetDacTinh(foodID: list_food[index], animalID: widget.animalID,)
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
              )
            ],
          )
          ),
      ),
    );
  }
}
