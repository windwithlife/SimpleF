import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../common/page.dart';
import '../home/model/categoriesList.dart' as categoriesList;
import '../common/block/swiper_block.dart';
import './block/slider_card_block.dart';


class ReadingHomePage extends Page {
  
  @override
  void initialize(ModelRegister register) {
   
    this.hasAppBar(true);
    this.initTitle("阅读频道");
  }
  @override
  Widget buildBody(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
      new SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width-20,
        child: SwiperBlock(
          categoriesList.list,
          (path) {
            print("this path to new page:$path");
            if (null != path) {
              Application.router.navigateTo(context, path);
            }
          },
          type: SWIPER_TYPE.NORMAL,
          itemHeight: 300,
          itemWidth: 400,
        ),
      ),
      new Expanded(
        flex:2, 
        child: new Text("Coming soon!"),//new ImageSliderCard(itemsList, onJumpTo:(){

        //})
        
      )]
    )
    );
  }
}
