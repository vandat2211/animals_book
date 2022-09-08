import 'package:animals_book/view/page/post_image.dart';
import 'package:animals_book/view/page/show_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> gettt =
        FirebaseFirestore.instance.collection('post_image').snapshots();
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        title: const Text("Animal Social"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/backgroundd.jpg'),
                  fit: BoxFit.cover)),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context)
                .push<void>(
              PostImage.route(
                 ),
            );
          }, icon: const Icon(Icons.image_sharp))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: gettt,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {}
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List list_image = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              list_image.add(a);
              a['id'] = document.id;
            }).toList();
            return Container(
              margin: const EdgeInsets.only(top: 20,bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 250),
                    itemCount: list_image.length,
                    itemBuilder: (context, index) {
                      final List list=list_image[index]['url_image'];
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.lightBlue.shade100),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(100),
                                    child: Image.network(
                                      list_image[index]['user_url'],
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list_image[index]
                                            ['user_name'],
                                        style: const TextStyle(
                                            fontWeight:
                                                FontWeight.bold),
                                      ),
                                       Text(list_image[index]['user_mail'])
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 2,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(8),
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.pink.shade400,
                                            borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                        child: const Center(
                                            child: Text(
                                          'Follow',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                                  FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                  child:list.length==1?
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverQuiltedGridDelegate(
                                        crossAxisCount: 2,
                                        repeatPattern:
                                        QuiltedGridRepeatPattern
                                            .inverted,
                                        pattern: [
                                          const QuiltedGridTile(
                                              1, 2),

                                        ]),
                                    itemCount: list.length,
                                    itemBuilder: (context,index){
                                     return InkWell(
                                       onTap: (){
                                         Navigator.of(context)
                                           .push<void>(
                                         ShowImage.route(
                                            list[index]
                                       ));
                                         },
                                       child: ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                12.0),
                                            child: Image.network(
                                              list[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                     );},
                                  )
                                      :list.length==2?
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverQuiltedGridDelegate(
                                        crossAxisCount: 2,
                                        repeatPattern:
                                        QuiltedGridRepeatPattern
                                            .inverted,
                                        pattern: [
                                          const QuiltedGridTile(
                                              1, 1),
                                        ]),
                                    itemCount: list.length,
                                    itemBuilder: (context,index){
                                     return InkWell(
                                       onTap: (){
                                         Navigator.of(context)
                                             .push<void>(
                                             ShowImage.route(
                                                 list[index]
                                             ));
                                       },
                                       child: ClipRRect(
                                         borderRadius:
                                         BorderRadius
                                             .circular(
                                             12.0),
                                         child: Image.network(
                                           list[index],
                                           fit: BoxFit.cover,
                                         ),
                                       ),
                                     );},

                                  )
                                      :list.length==3?
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverQuiltedGridDelegate(
                                        crossAxisCount: 4,
                                        mainAxisSpacing:
                                        4,
                                        crossAxisSpacing:
                                        4,
                                        repeatPattern:
                                        QuiltedGridRepeatPattern
                                            .inverted,
                                        pattern: [
                                          const QuiltedGridTile(
                                              2, 2),
                                          const QuiltedGridTile(
                                              1, 2),
                                          const QuiltedGridTile(
                                              1, 2),
                                        ]),
                                    itemCount: list.length,
                                    itemBuilder: (context,index){
                                      return InkWell(
                                        onTap: (){
                                          Navigator.of(context)
                                              .push<void>(
                                              ShowImage.route(
                                                  list[index]
                                              ));
                                        },
                                        child: ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            12.0),
                                        child: Image.network(
                                          list[index],
                                          fit: BoxFit.cover,
                                        ),
                                    ),
                                      );},

                                  )
                                      :GridView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                            SliverQuiltedGridDelegate(
                                                crossAxisCount: 4,
                                                mainAxisSpacing:
                                                4,
                                                crossAxisSpacing:
                                                4,
                                                repeatPattern:
                                                QuiltedGridRepeatPattern
                                                    .inverted,
                                                pattern: [
                                                  const QuiltedGridTile(
                                                      2, 2),
                                                  const QuiltedGridTile(
                                                      1, 1),
                                                  const QuiltedGridTile(
                                                      1, 1),
                                                  const QuiltedGridTile(
                                                      1, 2),
                                                ]),
                                            itemCount: list.length,
                                            itemBuilder: (context,index){
                                              return InkWell(
                                                onTap: (){
                                                  Navigator.of(context)
                                                      .push<void>(
                                                      ShowImage.route(
                                                          list[index]
                                                      ));
                                                },
                                                child: ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    12.0),
                                                child: Image.network(
                                                  list[index],
                                                  fit: BoxFit.cover,
                                                ),
                                            ),
                                              );},

                                          )
                                      )),
                          ],
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}
