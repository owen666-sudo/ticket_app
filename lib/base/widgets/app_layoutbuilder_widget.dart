import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLayoutbuilderWidget extends StatelessWidget {
  final int randomDriver;
  final double width;
  final bool? isColor;
  const AppLayoutbuilderWidget({super.key, required this.randomDriver, this.width=3, this.isColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            (constraints.constrainWidth()/randomDriver).floor(),
                (index) =>SizedBox(
                  width: width,
                  height: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration (
                      color: isColor==null?Colors.white:Colors.grey.shade300,
                    ),
                  ),
                ))
      );
    });
  }
}
