import 'package:provider/provider.dart'
  show ChangeNotifierProvider;
//import './CounterModel.dart';
import './UserModel.dart';




class ModelProviders extends Object{
  static List providers(){
    var providers = [
      //ChangeNotifierProvider(builder: (_) => Counter()),
      ChangeNotifierProvider(builder: (_) => UserModel.instance),
    ];
    return providers;
  }
}