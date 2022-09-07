import 'package:animals_book/app_bar.dart';
import 'package:animals_book/utils.dart';
import 'package:animals_book/view/page/animal_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class AnimalDeltailPage extends StatefulWidget {
   AnimalDeltailPage.init({Key? key,required this.animalID,required this.nameloai,required this.loaiID,required this.foodID,required this.nameloaiID,required this.namedacdiem,required this.name_animal,required this.des_animal,required this.url_animal}) : super(key: key);
  static Route route(
      String animalID,
   String foodID,
   String loaiID,
   String nameloai,
   String nameloaiID,
      String namedacdiem,
      String name_animal,
      String des_animal,
      String url_animal
     ){
    return Utils.pageRouteBuilder(AnimalDeltailPage.init(animalID: animalID, nameloai: nameloai, loaiID: loaiID, foodID: foodID, nameloaiID: nameloaiID, namedacdiem: namedacdiem, name_animal: name_animal, des_animal:des_animal, url_animal: url_animal,), true);
  }
  String animalID;
  String foodID;
  String loaiID;
  String nameloai;
  String nameloaiID;
  String namedacdiem;
  String name_animal;
  String des_animal;
  String url_animal;
  @override
  State<AnimalDeltailPage> createState() => _AnimalDeltailPageState();
}

class _AnimalDeltailPageState extends State<AnimalDeltailPage> {
  int indexx=0;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> image_animal = FirebaseFirestore.instance
        .collection('animal')
        .doc(widget.animalID)
        .collection('classify')
        .doc(widget.foodID)
        .collection('species')
        .doc(widget.loaiID)
        .collection(widget.nameloai)
        .doc(widget.nameloaiID)
        .collection(widget.nameloaiID)
        .snapshots();
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: Text(widget.namedacdiem + '(${widget.name_animal.toLowerCase()})'),
        showDefaultBackButton: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
               flex:3,
               child: StreamBuilder<QuerySnapshot>(
                 stream: image_animal,
                 builder: (BuildContext context,
                     AsyncSnapshot<QuerySnapshot> snapshot){
                   if (snapshot.hasError) {}
                   if (snapshot.connectionState ==
                       ConnectionState.waiting) {
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                   final List imagelist = [];
                   snapshot.data!.docs.map((DocumentSnapshot document) {
                     Map a = document.data() as Map<String, dynamic>;
                     imagelist.add(a);
                     a['id'] = document.id;
                   }).toList();
                   return imagelist.isEmpty?
                   Padding(
                     padding: const EdgeInsets.only(left:8.0,right:10,top:20,bottom:20),
                     child: Container(
                       decoration: BoxDecoration(
                           image: DecorationImage(
                               image: NetworkImage(widget.url_animal),
                               fit: BoxFit.cover),
                           borderRadius: BorderRadius.circular(8)),
                     ),
                   )
                   :Column(
                     children: [
                       CarouselSlider.builder(
                         options: CarouselOptions(
                             autoPlay: true,
                             enableInfiniteScroll: false,
                             autoPlayInterval: Duration(seconds: 2),
                             enlargeCenterPage: true,
                             onPageChanged:(index,reason){
                               print("indenkh: ${index}");
                               // setState((){
                               //   indexx==index;
                               // });
                             }
                         ),
                           itemCount: imagelist.length,
                           itemBuilder: (context,index,realindex){
                             final urlImage=imagelist[index]['image_animal'];
                             return buildImage(urlImage,index);
                           },
                           ),
                       SizedBox(height: 12,),
                       AnimatedSmoothIndicator(
                           effect: ExpandingDotsEffect(dotWidth: 15,activeDotColor: Colors.blue),
                           activeIndex: indexx=0,
                           count: imagelist.length
                       )
                     ],
                   );
                 }
               )),
           Expanded(flex:5,child:
           Padding(
             padding: const EdgeInsets.only(left: 10,right: 10),
             child: Container(
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(8)),
               child: SingleChildScrollView(
                 child: Html(
                  data: widget.des_animal,
                   style: {
                     "#": Style(
                         textAlign: TextAlign.left,
                         fontSize: const FontSize(12),
                         fontFamily: "Roboto",
                         lineHeight: const LineHeight(1.5))
                   },
                 ),
               ),
             ),
           ),)
          ],
        ),
      ),
    );
  }
  Widget buildImage(String urlImage,int index)=>
      Container(
  decoration: BoxDecoration(
      image: DecorationImage(
          image: NetworkImage(urlImage),
          fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(vertical:10,horizontal: 5),
      );

}
