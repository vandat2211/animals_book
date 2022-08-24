import 'package:animals_book/animal_page.dart';
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/get_dactinh.dart';
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
  List<String> docIDs=[];
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('animal').doc(widget.animalID).collection('dactinh').get().then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference);
      docIDs.add(document.reference.id);
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
                padding: const EdgeInsets.only(right: 20,left: 20,top: 50,bottom: 20),
                child: Container(
                  height: 200,
                    decoration:  BoxDecoration(
                        color: Colors.white24,
                        borderRadius:
                        BorderRadius.circular(10)),
                ),
              ),
              Container(
                height: 480,
                child: FutureBuilder(
                  future: getDocID(),
                  builder: (context,snapshot){
                  return GridView.builder(
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
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  AnimalPage(animalID:widget.animalID, dtID: docIDs[index], loaiID: 'XcTmLgjAIp8XVm1uiAt0', nameloai: 'loai su tu',)),
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
                                  GetDacTinh(ddId: docIDs[index], animalID: widget.animalID,)
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
