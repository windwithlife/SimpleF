import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';


class ImageCardItem {
  String uuid, title, imageUrl, tag, viewPagePath,sourceUrl;
  ImageCardItem.create(this.title, this.imageUrl, {this.tag}) {
    this.uuid = Uuid().v1();
  }
  ImageCardItem.update(this.title, this.imageUrl, {this.tag}) {
    this.uuid = Uuid().v1();
  }
}

class ImageSliderCard extends StatelessWidget {
  final List<ImageCardItem> itemsList;
  final Function onJumpTo;

  ImageSliderCard(this.itemsList, this.onJumpTo);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 50,
      child: ListView.builder(
        itemBuilder: (context, index) {
          ImageCardItem itemData = this.itemsList[index];
          return InkWell(
            onTap: () {
              this.onJumpTo();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(70),
                        offset: Offset(3.0, 10.0),
                        blurRadius: 15.0)
                  ]),
              height: 450.0,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: itemData.uuid + "_background",
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: itemData.uuid + "_title",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              itemData.title,
                              style: TextStyle(fontSize: 30.0),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        scrollDirection: Axis.horizontal,
        //physics: _CustomScrollPhysics(),
        //controller: scrollController,
        itemExtent: _width - 80,
        itemCount: this.itemsList.length, //.todoProjects.length,
      ),
    );
  }
}
