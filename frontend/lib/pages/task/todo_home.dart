import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import './model/DummyData.dart';
//import './model/CustomIcons.dart';
//import './model/TodoObject.dart';
//import './Details.dart';
import '../common/page.dart';
import './model/TodoProjectEntity.dart';
//import './model/TodoModel.dart';
import './model/TaskProjectModel.dart';
import './block/page_card.dart';

class TodoHomePage extends Page {
  //TodoModel pageModel = TodoModel.instance;
  ScrollController scrollController;
  Color backgroundColor;
  LinearGradient backgroundGradient;
  Tween<Color> colorTween;
 

  @override
  void initialize(ModelRegister register) {
  
    TaskProjectModel model = Store.valueOf<TaskProjectModel>();
    List<Project> todos = model.todoProjects;
    
    colorTween = ColorTween(begin: todos[0].color, end: todos[0].color);
    backgroundColor = todos[0].color;
    backgroundGradient = todos[0].gradient;
    scrollController = ScrollController();
    scrollController.addListener(() {
      ScrollPosition position = scrollController.position;

      int page = position.pixels ~/
          (position.maxScrollExtent / (todos.length.toDouble() - 1));
      double pageDo = (position.pixels /
          (position.maxScrollExtent / (todos.length.toDouble() - 1)));
      double percent = pageDo - page;
      if (todos.length - 1 < page + 1) {
        return;
      }
      colorTween.begin = todos[page].color;
      colorTween.end = todos[page + 1].color;
     
      backgroundColor = colorTween.transform(percent);
      backgroundGradient =
          todos[page].gradient.lerpTo(todos[page + 1].gradient, percent);
      model.changePageBackground(backgroundGradient);
      
    });
    //this.pageModel.getTodoProjects();
  }

  @override
  Widget buildBody(BuildContext context) {
    return  _buildTodoHomePage(context);
    
  }


  Widget _buildTodoHomePage(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;


    return Store.connect<TaskProjectModel>(builder: (BuildContext context, TaskProjectModel model, Widget child) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("备忘录"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 26.0,
              ),
              onPressed: () {
                  this.goto(context, '/task/taskProjectList');
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0)
                  ],
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Text(
                "Hello, 张连铖.",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 50,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Project todoObject = model.todoProjects[index];
                  return new PageSliderCard(todoObject, () {
                    this.goto(context, '/task/taskList?projectId=1');
                  });
                },
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                scrollDirection: Axis.horizontal,
                //physics: _CustomScrollPhysics(),
                controller: scrollController,
                itemExtent: _width - 80,
                itemCount: model.todoProjects.length,
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
    });
  }
}
/* 
class _CustomScrollPhysics extends ScrollPhysics {
  _CustomScrollPhysics({
    ScrollPhysics parent,
  }) : super(parent: parent);

  @override
  _CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return _CustomScrollPhysics(parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels /
        (position.maxScrollExtent / (todos.length.toDouble() - 1));
    // return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollPosition position, double page) {
    // return page * position.viewportDimension;
    return page * (position.maxScrollExtent / (todos.length.toDouble() - 1));
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }
}
 */