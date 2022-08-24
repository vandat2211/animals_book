
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLoai extends StatelessWidget {
 final String animalID;
 final String ddid;
 final String loaiid;
 final String namelaoi;
  const GetLoai({Key? key, required this.animalID, required this.ddid, required this.loaiid, required this.namelaoi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference dd=FirebaseFirestore.instance.collection('animal').doc(animalID).collection('dactinh').doc(ddid).collection('loai').doc(loaiid).collection(namelaoi);
    return FutureBuilder<DocumentSnapshot>(
        future: dd.doc(loaiid).get(),
        builder: ((context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data=
            snapshot.data!.data() as Map<String,dynamic>;
            return
              Text('${data['name_dv']}');
          }
          return Text("loading...");
        }));
  }
}
