import 'package:provider/provider.dart'
  show ChangeNotifierProvider,SingleChildCloneableWidget;
import './UserModel.dart';
import '../../pages/task/model/TaskProjectModel.dart';
import '../../pages/task/model/TasksModel.dart';





class ModelProviders extends Object{
  static List<SingleChildCloneableWidget> providers(){
    var providers = [
      //ChangeNotifierProvider(builder: (_) => Counter()),
      ChangeNotifierProvider(builder: (_) => UserModel.instance),
      ChangeNotifierProvider(builder: (_) => TaskProjectModel()),
      ChangeNotifierProvider(builder: (_) => TasksModel()),
      
      
    ];
    return providers;
  }
}