import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../common/page.dart';
import './model/categoriesList.dart' as categoriesList;
//import './blocks/slider_card_block.dart';
import '../common/block/swiper_block.dart';
import './blocks/function_buttons_block.dart';

class CategoriesScreen extends Page {
  
  @override
  void initialize(ModelRegister register) {
    // TODO: implement initialize
    super.initialize(register);
    this.hasAppBar(true);
    this.initTitle("首页");
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
        child: FunctionButtonsBlock( categoriesList.list,
          (path) {
            print("this path to new page:$path");
            if (null != path) {
              Application.router.navigateTo(context, path);
            }
          })
      )]
    )
    );
  }
}
