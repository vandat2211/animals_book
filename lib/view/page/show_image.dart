
import 'package:animals_book/app_bar.dart';
import 'package:animals_book/utils.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
   ShowImage({Key? key,required this.image}) : super(key: key);
   static Route route(String image) {
     return Utils.pageRouteBuilder(ShowImage(image: image,), false);
   }
String image;
  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: CustomAppBar(
        context,
        title: Text("Image"),
        showDefaultBackButton: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover)),
        ),
        leading: IconButton(
          onPressed: () {
              Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(widget.image),
        ),
      ),
    );
  }
}
