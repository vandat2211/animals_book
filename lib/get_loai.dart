
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLoai extends StatelessWidget {
 final String animalID;
 final String foodID;
 final String loaiid;
 final String dvid;
 final String namelaoi;
  const GetLoai({Key? key, required this.animalID, required this.foodID, required this.loaiid, required this.namelaoi, required this.dvid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference dd=FirebaseFirestore.instance.collection('animal').doc(animalID).collection('food').doc(foodID).collection('species').doc(loaiid).collection(namelaoi);
    return FutureBuilder<DocumentSnapshot>(
        future: dd.doc(dvid).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            return
              Text('${data['name_animal']}');
          }
          return Text("loading...");
        }));
  }
}
