import 'package:flutter/material.dart';
import 'package:usefulmcqapp/view_model/fetch_mcqs.dart';

import '../displaymcqs.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreenForMcqs extends StatefulWidget {
  const HomeScreenForMcqs({Key? key}) : super(key: key);

  @override
  State<HomeScreenForMcqs> createState() => _HomeScreenForMcqsState();
}

class _HomeScreenForMcqsState extends State<HomeScreenForMcqs> {
  late bool _isLoading;
  late Future<dynamic> dataFuture;

  List<String> iconImages = [
    'https://cdn-icons-png.flaticon.com/512/3261/3261308.png',
    'https://cdn-icons-png.flaticon.com/512/2022/2022268.png',
    'https://cdn-icons-png.flaticon.com/512/2547/2547959.png',
    'https://cdn-icons-png.flaticon.com/512/8132/8132594.png',
    'https://cdn-icons-png.flaticon.com/512/814/814513.png',
    'https://cdn-icons-png.flaticon.com/512/1048/1048971.png',
    'https://cdn-icons-png.flaticon.com/512/2547/2547959.png',
  ];

  List<String> name = [
    'Current Affairs',
    'Everday Science',
    'General Knowledge',
    'Pakistan Affairs',
    'World Affairs',
    'Other'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    dataFuture = context.read<FetchMcqs>().getCategory();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F6FF),
      body: !_isLoading? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    buildTopContainer(context),
                    SizedBox(
                      height: 20,
                    ),
                    buildRow(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount:
                              context.watch<FetchMcqs>().categories.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {
                                /// here
                                context.read<FetchMcqs>().getListById(
                                    context
                                        .read<FetchMcqs>()
                                        .categories[index]
                                        .title
                                        .toString(),
                                    context);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      // color: Colors.amber,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: context
                                          .read<FetchMcqs>()
                                          .categories[index].description.toString().isEmpty?iconImages[0]
                                          :context
                                          .read<FetchMcqs>()
                                          .categories[index].description,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fill,
                                        placeholder: (context, url) => Container(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      // Image.network(
                                      //   context
                                      //       .watch<FetchMcqs>()
                                      //       .categories[index].description.toString().isEmpty?iconImages[0]
                                      //   :context
                                      //       .watch<FetchMcqs>()
                                      //       .categories[index].description,
                                      //   height: 50,
                                      //   width: 50,
                                      //   fit: BoxFit.fill,
                                        // loadingBuilder: (BuildContext context, Widget child,
                                        //     ImageChunkEvent? loadingProgress) {
                                        //   if (loadingProgress == null) return child;
                                        //   return CircularProgressIndicator(
                                        //     color: Color(0xFF7456F5),
                                        //     value: loadingProgress.expectedTotalBytes != null
                                        //         ? loadingProgress.cumulativeBytesLoaded /
                                        //         loadingProgress.expectedTotalBytes!
                                        //         : null,
                                        //   );
                                        // },
                                      //),
                                      // Image.network(iconImages[index],
                                      //   height: 50,
                                      //   width: 50,
                                      //   fit: BoxFit.fill,
                                      // ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: Center(
                                            child: Text(
                                              index==0?"Islamiat":
                                              context
                                                  .watch<FetchMcqs>()
                                                  .categories[index]
                                                  .title,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                    ],
                                  )),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )

          // Displaying LoadingSpinner to indicate waiting state
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // buildTopContainer(context),
                  buildTopContainerShimmer(context),

                  SizedBox(
                    height: 20,
                  ),
                  buildRow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 3,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: 6,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>  DisplayMcqs()),
                              // );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.04),
                                    // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.04),
                                      ),
                                    ),
                                    // Image.network(
                                    //   iconImages[index],
                                    //   height: 50,
                                    //   width: 50,
                                    //   fit: BoxFit.fill,
                                    //   loadingBuilder: (BuildContext context, Widget child,
                                    //       ImageChunkEvent? loadingProgress) {
                                    //     if (loadingProgress == null) return child;
                                    //     return CircularProgressIndicator(
                                    //       color: Color(0xFF7456F5),
                                    //       value: loadingProgress.expectedTotalBytes != null
                                    //           ? loadingProgress.cumulativeBytesLoaded /
                                    //           loadingProgress.expectedTotalBytes!
                                    //           : null,
                                    //     );
                                    //   },
                                    // ),
                                    // Image.network(iconImages[index],
                                    //   height: 50,
                                    //   width: 50,
                                    //   fit: BoxFit.fill,
                                    // ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      // child: Center(
                                      //   child: Text(name[index],
                                      //     overflow: TextOverflow.ellipsis,
                                      //   ),
                                      // )
                                    )
                                  ],
                                )),
                              ),
                            ),
                          );
                        }),
                  )
                ],

              ),


        // Future that needs to be resolved
        // inorder to display something on the Canvas

      ),
    );
  }

  buildTopContainerShimmer(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.04),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 30,
                  color: Theme.of(context).primaryColor.withOpacity(0.04),
                )
                // Text("Hello",
                //
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold
                //   ),
                // ),

                // Icon(
                //   Icons.notifications,
                //   color: Colors.white,
                //   size: 25,
                // )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(8,0,0,30),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Text("Good Morning",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18
          //         ),
          //       ),
          //
          //     ],
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child:  Padding(
          //     padding: EdgeInsets.fromLTRB(15,0,15,25),
          //     child: TextField(
          //
          //       decoration: InputDecoration(
          //           prefixIcon: Icon(
          //               Icons.search
          //           ),
          //           border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           filled: true,
          //           hintStyle: TextStyle(color: Colors.grey[800]),
          //           hintText: "Search Category",
          //           fillColor: Color(0xFFFFFFFF)),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding buildRow() {
    return !_isLoading
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Categories',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 14, color: Color(0xFF7456F5)),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Categories',
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor.withOpacity(0.04)),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor.withOpacity(0.04)),
                ),
              ],
            ),
          );
  }

  Container buildTopContainer(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xFF7456F5),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2, 8, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 25,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Good Morning",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Search Category",
                    fillColor: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
