
import 'dart:io';

import 'package:animals_book/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart'as Path;
class PostImage extends StatefulWidget {
  const PostImage({Key? key}) : super(key: key);
  static Route route() {
    return Utils.pageRouteBuilder(PostImage(), false);
  }
  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  String? name='';
  String? email='';
  String? user_url='';
  Future _getData()async{
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((snapshot)async{
      if(snapshot.exists){
       name= snapshot.data()!["user_name"];
       email= snapshot.data()!["email"];
       user_url= snapshot.data()!["user_url"];
      }
    });
  }

  final ImagePicker _picker=ImagePicker();
  List<File> image=[];
  List<String> downloadUrls=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        title: Text("Post image"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: image.length+1,
                    itemBuilder: (context,index){
                      return index==0?
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: (){ getMultipImage();},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: const Center(
                                  child: Icon(Icons.add,size: 40,)
                            ),
                              )
                            )
                          ):Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(onTap: (){
                              setState((){
                              image.removeAt(index-1);
                            });
                              },child: ClipRRect(borderRadius:BorderRadius.circular(20),child: Image.file(File(image[index-1].path),fit: BoxFit.cover,))),
                          );
                    }),
              ),
            ),
            Expanded(
              flex: 3,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 5,
                      minLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',border: OutlineInputBorder()
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: () async {
                      for(int i=0;i<image.length;i++){
                       String url=await uploadFile(image[i]);
                       downloadUrls.add(url);
                       if(i==image.length-1){
                         storeEntry(downloadUrls);
                       }
                      }
                    }, child: Text("Upload"))
                  ],
                )),

          ],
        ),
      ),
    );
  }

 getMultipImage()async{
    final List<XFile>? pickedImages=await _picker.pickMultiImage();
    if(pickedImages!=null){
      pickedImages.forEach((e) {image.add(File(e.path)); });
      setState((){});
    }
 }
 Future<String> uploadFile(File file)async{
    final metaData=SettableMetadata(contentType: 'image/jpeg');
    final storageRef=FirebaseStorage.instance.ref();
    Reference ref=storageRef.child('picture/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask=ref.putFile(file,metaData);
  final taskSnapshot=await uploadTask.whenComplete(() {
   });
    String url=await taskSnapshot.ref.getDownloadURL();
  return url;
 }
  storeEntry(List<String> imageurls){
    FirebaseFirestore.instance.collection('post_image').add({
      'user_url':user_url,
      'user_name':name,
      'user_mail':email,
      'url_image':imageurls
      }).then((DocumentReference doc) {
      // final String docID=doc.id;
      // FirebaseFirestore.instance.collection('post_image').doc(docID).collection(docID).add({
      // });
      });
  }
}
