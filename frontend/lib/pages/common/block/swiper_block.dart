import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

enum SWIPER_TYPE { NORMAL, STACK, FAN }

class SwiperBlock extends StatelessWidget {
  final List<dynamic> itemsList;
  final Function onJumpTo;
  SWIPER_TYPE _type;
  int _itemHeight;
  int _itemWidth;
  //int _itemCount = 10;
  SwiperBlock(this.itemsList, this.onJumpTo,
      {SWIPER_TYPE type = SWIPER_TYPE.NORMAL, int itemHeight, int itemWidth}) {
    if (null != type) {
      this._type = type;
    }
  }

  void addItem(Map<String, Object> item) {
    this.itemsList.add(item);
  }

  @override
  Widget build(BuildContext context) {
    //int itemCount = this.itemsList.length;
    int itemCount = 10;
    if (this._type == SWIPER_TYPE.NORMAL) {
      return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: itemCount,
        viewportFraction: 0.8,
        scale: 0.9,
        onTap: (index) {
          print("current tap is $index");
          this.onJumpTo(itemsList[index]["url"]);
        },
      );
    }

    if (SWIPER_TYPE.STACK == _type) {
      return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: itemCount,
        itemWidth: 300.0,
        itemHeight: 400.0,
        layout: SwiperLayout.STACK,
        onTap: (index) {
          print("current tap is $index");
          this.onJumpTo(itemsList[index]["url"]);
        },
      );
    }

    if (SWIPER_TYPE.FAN == _type) {
      return new Swiper(
        layout: SwiperLayout.CUSTOM,
        customLayoutOption:
            new CustomLayoutOption(startIndex: -1, stateCount: 3)
                .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
          new Offset(-370.0, -40.0),
          new Offset(0.0, 0.0),
          new Offset(370.0, -40.0)
        ]),
        itemWidth: 300.0,
        itemHeight: 200.0,
        itemBuilder: (context, index) {
          return new Container(
            color: Colors.grey,
            child: new Center(
              child: new Text("$index"),
            ),
          );
        },
        itemCount: itemCount,
        onTap: (index) {
          print("current tap is $index");
          this.onJumpTo(itemsList[index]["url"]);
        },
      );
    } //if
  }
}
