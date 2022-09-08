
import 'dart:io';

import 'package:animals_book/resource/assets.dart';
import 'package:animals_book/utils.dart';
import 'package:animals_book/view/page/show_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class ChangeInfo extends StatefulWidget {
   ChangeInfo.init({Key? key,required this.name,required this.age,required this.image}) : super(key: key);
   static Route route(String name,String age,String image) {
     return Utils.pageRouteBuilder(
         ChangeInfo.init(age: age, name:name, image: image,
         ),
         true);
   }
String name;
String age;
String? image;
  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  File? image;
Future pickImage(ImageSource source)async{
 try {
   final image= await ImagePicker().pickImage(source: source);
    if(image==null)return;
    final imageTemporary=File(image.path);
    setState((){
      this.image=imageTemporary;
    });
 } on PlatformException catch (e) {
   print('Failed to pick image : $e');
 }
}
 show_option(BuildContext context){
   showDialog(context: context, builder: (BuildContext context){
    return  AlertDialog(
      title: const Text("Choose option",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blueAccent
        ),),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            InkWell(
              onTap: (){pickImage(ImageSource.camera);Navigator.of(context).pop();},
              splashColor: Colors.purpleAccent,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt,color: Colors.black,),
                  ),
                  Text("Camera",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){pickImage(ImageSource.gallery);Navigator.of(context).pop();},
              splashColor: Colors.purpleAccent,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.image,color: Colors.black,),
                  ),
                  Text("Gallery",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  });
}
Future<ImageSource?> showImageSource(BuildContext context)async{
  if(Platform.isIOS){
    return showCupertinoModalPopup<ImageSource>(context: context, builder: (context)=>CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(onPressed: (){pickImage(ImageSource.camera);Navigator.of(context).pop();}, child: Text("Camera")),
        CupertinoActionSheetAction(onPressed: (){pickImage(ImageSource.gallery);Navigator.of(context).pop();}, child: Text("Gallery"))
      ],
    ));
  }
  else{
    return showModalBottomSheet(context: context, builder: (context)=>Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: (){pickImage(ImageSource.camera);Navigator.of(context).pop();},
        ),
        ListTile(
          leading: const Icon(Icons.image_sharp),
          title: const Text('Gallery'),
          onTap: (){pickImage(ImageSource.gallery);Navigator.of(context).pop();},
        ),
      ],
    ));
  }
}
  Future<String> uploadImage(File file)async{
    final metaData=SettableMetadata(contentType: 'image/jpeg');
    final storageRef=FirebaseStorage.instance.ref();
    Reference ref=storageRef.child('picturee/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask=ref.putFile(file,metaData);
    final taskSnapshot=await uploadTask.whenComplete(() {
    });
    String url=await taskSnapshot.ref.getDownloadURL();
    updateUserDetail(url);
    return url;
  }
  Future updateUserDetail(String img_new)async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'user_url':img_new
    });
  }
  final _name = TextEditingController();
  final _age = TextEditingController();
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    myFocusNode.dispose();
    _name.dispose();
    _age.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Utils.bkavCheckOrientation(context, Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAsset.loginBackgroundd),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .push<void>(
                          ShowImage.route(
                              widget.image!
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:image!=null?Image.file(image!,fit: BoxFit.cover,width: 200,height: 200,):widget.image!=""?Image.network(widget.image!,fit: BoxFit.cover,height: 200,width: 200,):Image.asset(ImageAsset.loginBackgroundd,fit: BoxFit.cover,height: 200,width: 200,),
                    ),
                  ),
                 Padding(
                   padding: const EdgeInsets.only(top: 150,left: 140),
                   child: IconButton(onPressed: (){
                     // showImageSource(context);
                     show_option(context);
                   }, icon: Icon(Icons.camera_alt,size: 40,)),
                 )
                ],
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      focusNode: myFocusNode,
                      controller: _name,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'FirstName'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _age,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'LastName'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: ()async{uploadImage(image!);},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
