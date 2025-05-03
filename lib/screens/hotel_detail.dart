import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';
import 'package:ticket_app/base/utils/all_json.dart';
import 'package:ticket_app/controller/text_exapnsion_controller.dart';
import 'package:get/get.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
late int index=0;
  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args["index"]);
    index = args["index"];
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.primaryColor
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              //title: Text(hotelList[index]["place"]),
              background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/images/${hotelList[index]["image"]}",
                        fit: BoxFit.cover,
                    )),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4
                        ),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                              hotelList[index]["place"],
                              style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 0.0,
                                    color: Colors.red ,
                                    //color: AppStyles.primaryColor,
                                    offset: const Offset(2.0, 2.0)
                                  )
                                ]
                            ),
                          )
                      ),
                    )
                  ],
                )
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ExpandTextWidget(
                   text: hotelList[index]["detail"],
              )
                /*Text(
              "In this article, we will create a custom scrollable app bar with a background image in Flutter. The app bar will shrink as the user scrolls up, and it will include a back button. Below the image, we will display some descriptive text with a More or Less button to show or hide additional text. Finally, we will add a section to display recent images in a horizontal list."
              ),*/
              ),
              const Padding(padding: EdgeInsets.all(16.0),
              child: Text(
                "More Images",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
              )),
            SizedBox(
              height: 200.0,
              child:ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: hotelList[index]["images"].length,
                  itemBuilder: (context, imagesIndex){
                    print("${hotelList[index]["images"][0]}");
                    return Container(
                        margin: EdgeInsets.all(16),
                        color: Colors.red,
                        child: Image.asset(
                            "assets/images/${hotelList[index]["images"][imagesIndex]}"));
                  } ),
            )
          ]))
        ],
      ),
    );
  }
}

class ExpandTextWidget extends StatelessWidget {
  ExpandTextWidget({super.key, required this.text});
  final String text;

  final TextExpansionController controller = Get.put(TextExpansionController());
  @override
  Widget build(BuildContext context) {

    return Obx((){
      var textWidget = Text(
        text,
        maxLines: controller.isExpanded.value?null:9,
        overflow: controller.isExpanded.value?TextOverflow.visible:TextOverflow.ellipsis,
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget,
          GestureDetector(
            onTap: (){
              controller.toggleExpansion();
            },
            child: Text(
              controller.isExpanded.value?'Less':'More',
              style: AppStyles.textStyle.copyWith(
                  color: AppStyles.primaryColor
              ),
            ),
          )
        ],
      );
    });
  }
}

