import 'package:flutter/material.dart';
import './page.dart';
class PageWrapper extends StatefulWidget {
  
  PageWrapper(this.child){
    //print('************create a new PageWrapper!!!!!!**********');
  }

  //final T bloc;
  final Page child;

  @override
  _PageBuilderState createState() => _PageBuilderState();

}

class _PageBuilderState<T> extends State<PageWrapper> {
  @override
  void dispose() {
    //widget.bloc.dispose();
    print('********************************!!!!!WrapperPage--dispose!!!');
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
   
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    //const bool inDebug = const bool.fromEnvironment("dart.vm.debug");
    //print('*************current run evnirnoment: product is ***************' + inProduction.toString() );
    //if (!inProduction){
    //  this.widget.child.initialize();
    //}
    return this.widget.child;
  }
  @override
  void initState(){
    print('********************************!!!!!WrapperPage--initState!!!');
     this.widget.child.initialize();
      this.widget.child.willUpdatePage();  
  }
  @override
  void didChangeDependencies(){
   super.didChangeDependencies();
    print('********************************!!!!!WrapperPage--didChangeDependencies!!!');
    // var bool = ModalRoute.of(context).isCurrent;
    // if (bool) {
    //    //this.widget.child.willUpdatePage();
    //   print('********************************!!!!!WrapperPage--didChangeDependencies----current route page!!!');
    // }else{
    //   print('********************************!!!!!WrapperPage--didChangeDependencies!!!');
    // }
    
  }

  @override
  void didUpdateWidget(Widget oldWidget){
    
    super.didUpdateWidget(oldWidget);
    //this.widget.child.showPageTrace("didUpdateWidget callback");
    this.widget.child.willUpdatePage();
    print('********************************!!!!!WrapperPage--didUpdateWidget!!!');
  }
  @override
  void  deactivate(){
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
       this.widget.child.willUpdatePage();
       print('********************************!!!!!WrapperPage--deactivate----current route page!!!');
    }else{
      print('********************************!!!!!WrapperPage--deactivate!!!');
    }
    //print('********************************!!!!!WrapperPage--deactivate!!!');
  }
 
}
