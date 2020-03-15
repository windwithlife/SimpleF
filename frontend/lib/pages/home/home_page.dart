import 'package:flutter/material.dart';
import '../common/page.dart';
import './model/HomeModel.dart';

class HomePage extends Page {
  HomeModel pageModel = new HomeModel();
  HomePage(){
    print('create a now object of HomePage Class');
  }
  @override
  void initialize(ModelRegister register){
    register.registerModel(ChangeNotifierProvider.value(value: this.pageModel));
      //this.initExtModel(new HomeModel());
      print('initialize in home page!');
  }
  

  @override
  Widget buildBody(BuildContext context){
    return new Text('homepage');
   
  }
  
}
