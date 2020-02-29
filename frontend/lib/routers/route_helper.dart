import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../application.dart';
import '../pages/common/page.dart';

class RouterConfigList {
  final routerMap = new Map<String, Object>();

  Map<String, Object> getRouterList() {
    return this.routerMap;
  }

  void addRouteConfigItem(String path, dynamic pageBuilder) {
    this.routerMap[path] = pageBuilder;
  }

  void addRoutes(RouterConfigList routeMap) {}
}

class RouteRegister {
  static RouteRegister _instance = new RouteRegister();

  static addAndUpdateRoute(String path, dynamic pageBuilder) {
    _instance.registerRoute(path, pageBuilder);
  }

  static registerAllConfigRoutes(RouterConfigList configItems) {
    configItems.addRoutes(configItems);
    _instance.registerRoutes(configItems);
  }

  void registerRoutes(RouterConfigList configItems) {
    configItems.getRouterList().forEach((String key, Object pageBuilder) {
      this.registerRoute(key, pageBuilder);
    });
  }

  void registerRoute(String path, dynamic pageBuilder) {
    Handler pageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
                       dynamic page = pageBuilder(params);
                       if (page is Page){
                          print("**********************page init**********");
                          //page.onShow();
                       }
                       //page.init();
                       return page;
                     });
    //print("**********************URL PATH**********");
    //print(path);
    Application.router.define(path, handler: pageHandler);
  }
}
