import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';



class SliderCardBlock extends StatelessWidget {
  final List<dynamic> itemsList;
  final Function onJumpTo;
  
  SliderCardBlock(this.itemsList, this.onJumpTo) {
   
  }

  void addItem(Map<String, Object> item) {
    this.itemsList.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
        child: new Swiper(
          outer: false,
          itemBuilder: (c, i) {
            return new Wrap(
              runSpacing: 6.0,
              children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                return new SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new SizedBox(
                        child: new Container(
                          child: new Image.network(
                              "https://fuss10.elemecdn.com/c/db/d20d49e5029281b9b73db1c5ec6f9jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90"),
                        ),
                        height: MediaQuery.of(context).size.width * 0.12,
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 6.0),
                        child: new Text("$i"),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
          pagination: new SwiperPagination(margin: new EdgeInsets.all(5.0)),
          itemCount: 10,
        ),
        constraints: new BoxConstraints.loose(new Size(400, 170.0)));
  }
}
