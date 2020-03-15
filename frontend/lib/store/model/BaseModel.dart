import 'package:flutter/foundation.dart' show ChangeNotifier;

class BaseModel extends ChangeNotifier {
  
  String modelName = "base-model";
  bool isLoading = false;
 
  
  void refresh(){
    notifyListeners();
  }
  String getModelName(){
    return this.modelName;
  }

}