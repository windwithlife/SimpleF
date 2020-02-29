import 'package:flutter/foundation.dart' show ChangeNotifier;

class BaseModel extends ChangeNotifier {
  
  String modelName = "base-model";
 
  bool hasData() {
    return false;
  }
  void refresh(){
    notifyListeners();
  }
  String getModelName(){
    return this.modelName;
  }

}