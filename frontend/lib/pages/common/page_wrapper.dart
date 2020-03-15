import 'package:flutter/material.dart';
import './page.dart';

class PageWrapper extends StatefulWidget {
  PageWrapper(this.child, this.defaultBuilder) {
    //print('************create a new PageWrapper!!!!!!**********');
  }

  //final T bloc;
  final Page child;
  final SingleChildCloneableWidget defaultBuilder;

  @override
  _PageBuilderState createState() => _PageBuilderState();
}

class _PageBuilderState<T> extends State<PageWrapper> {
  List<SingleChildCloneableWidget> providers =
      new List<SingleChildCloneableWidget>();
  @override
  void dispose() {
    //widget.bloc.dispose();
    print('********************************!!!!!WrapperPage--dispose!!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    //const bool inDebug = const bool.fromEnvironment("dart.vm.debug");
    //print('*************current run evnirnoment: product is ***************' + inProduction.toString() );
    //if (!inProduction){
    //  this.widget.child.initialize();
    //}
    print("build in swrap!");
    if (this.providers.length <= 0) {
      return this.widget.child;
    } else {
      return MultiProvider(
        providers: this.providers,
        child: this.widget.child,
      );
    }
  }

  @override
  void initState() {
    print('********************************!!!!!WrapperPage--initState!!!');
    this.widget.child.initialize(ModelRegister(this.providers));
    //this.widget.child.onRegisterModels(ModelRegister(this.providers));

    // List<SingleChildCloneableWidget> registerProviders =
    //         if (null != registerProviders && registerProviders.length > 0) {
    //   this.providers.addAll(registerProviders);
    // }
    if (null != this.widget.defaultBuilder) {
      this.providers.add(this.widget.defaultBuilder);
    }
    /*
    List registerProviders = this.widget.child.onRegisterModels();
    if (registerProviders != null){
      this.providers.addAll(registerProviders);
    }
    this.providers.add(this.widget.defaultBuilder);
    */
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
        '********************************!!!!!WrapperPage--didChangeDependencies!!!');
    // var bool = ModalRoute.of(context).isCurrent;
    // if (bool) {
    //    //this.widget.child.willUpdatePage();
    //   print('********************************!!!!!WrapperPage--didChangeDependencies----current route page!!!');
    // }else{
    //   print('********************************!!!!!WrapperPage--didChangeDependencies!!!');
    // }
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //this.widget.child.showPageTrace("didUpdateWidget callback");
    //this.widget.child.willUpdatePage();
    print(
        '********************************!!!!!WrapperPage--didUpdateWidget!!!');
  }

  @override
  void deactivate() {
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      this.widget.child.onPageBack();
      print(
          '********************************!!!!!WrapperPage--deactivate----current route page!!!');
    } else {
      print('********************************!!!!!WrapperPage--deactivate!!!');
    }
    //print('********************************!!!!!WrapperPage--deactivate!!!');
  }
}



class ModelRegister {
  List<SingleChildCloneableWidget> _providers;
  ModelRegister(this._providers);
  void registerModel(SingleChildCloneableWidget provider) {
    if (null != provider){
      this._providers.add(provider);
    }
  }
  void registerModelBuilder(Function buillder) {
    if (null != buillder){
      this._providers.add(ChangeNotifierProvider(builder: buillder));
    }
  }
}
