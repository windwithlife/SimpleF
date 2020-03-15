import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart'
   show MultiProvider, Consumer, Provider,ChangeNotifierProvider;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import './model/index.dart';
export 'package:provider/provider.dart';

class Store {
  static BuildContext globalCtx;
  static BuildContext widgetCtx;
  static BuildContext pageCtx;
  static setCurrentPageContext(BuildContext pageContext){
    pageCtx =pageContext;
  }
  static init({context, child}) {
    return MultiProvider(
      providers: ModelProviders.providers(),
      child: child,
    );
  }

  static T value<T>(context) {
    return Provider.of<T>(context);
  }
  static T valueOf<T>() {
    if (null != pageCtx){
      return Provider.of<T>(pageCtx,listen: false);
    }else{
      return Provider.of(globalCtx,listen: false);
    }
    
  }
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
  static  ChangeNotifierProvider provide<T extends ChangeNotifier>(T pData,builder){
    return ChangeNotifierProvider<T>.value(value: pData,child: Consumer<T>(builder: builder));
  }
}