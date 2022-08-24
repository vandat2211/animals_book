
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetL extends StatelessWidget {
  const GetL({Key? key, required this.animalID, required this.ddid, required this.loaiid}) : super(key: key);
  final String animalID;
  final String ddid;
  final String loaiid;
  @override
  Widget build(BuildContext context) {
    CollectionReference dd=FirebaseFirestore.instance.collection('animal').doc(animalID).collection('dactinh').doc(ddid).collection('loai');
    return FutureBuilder<DocumentSnapshot>(
        future: dd.doc(loaiid).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            return
              Text('${data['name_loai']}');
          }
          return Text("loading...");
        }));
  }

}
