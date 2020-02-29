import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../application.dart';
import './route_helper.dart';
import './route_register_config.dart';

class Routes {
  //static String root = '/';
  //static String detailsPage = '/detail'; //详情页面
  //静态方法
  static void configureRoutes() {
    //路由配置
    //找不到路由
    Application.router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
      return null;
    });

    //整体配置
    RouteRegister.registerAllConfigRoutes(RouteConfigs());
  }
}
