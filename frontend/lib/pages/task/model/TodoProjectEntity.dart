import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
//import './TaskEntity.dart';


enum TodoCardSettings { edit_color, delete }

class Project {
  static final tblProject = "projects";
  static final dbId = "id";
  static final dbName = "name";
  static final dbColorCode = "colorCode";
  static final dbColorName = "colorName";

  int id, colorValue;
  String uuid,name, colorName;
  Color color;
  LinearGradient gradient;
  IconData icon;
 

  int taskAmount() {
    int amount = 0;
   
    return amount;
  }

  double percentComplete() {
    
    return 1.0;
  }

  Project.create(this.name, {this.colorName=""}){
    ColorChoice choice = ColorChoices.choices[Random().nextInt(ColorChoices.choices.length)];
    this.color = choice.primary;
    this.colorValue = this.color.value;
    this.gradient = LinearGradient(colors: choice.gradient, begin: Alignment.bottomCenter, end: Alignment.topCenter);
    this.uuid = Uuid().v1();
  }

  Project.update({@required this.id, name, colorCode = "", colorName = ""}) {
    if (name != "") {
      this.name = name;
    }
    ColorChoice choice = ColorChoices.choices[Random().nextInt(ColorChoices.choices.length)];
    this.color = choice.primary;
    this.gradient = LinearGradient(colors: choice.gradient, begin: Alignment.bottomCenter, end: Alignment.topCenter);
    
    if (colorCode != "") {
      this.colorValue = colorCode;
      this.color = this.colorValue ==null? Color(256):Color(this.colorValue);
    }
    if (colorName != "") {
      this.colorName = colorName;
    }
    this.uuid = Uuid().v1();
  }

  Project.getInbox()
      : this.update(
            id: 1,
            name: "Inbox",
            colorName: "Grey",
            colorCode: Colors.grey.value);

  Project.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId],
            name: map[dbName],
            colorCode: map[dbColorCode],
            colorName: map[dbColorName]);
}





class ColorChoice {
  ColorChoice({@required this.primary, @required this.gradient});

  final Color primary;
  final List<Color> gradient;
}

class ColorChoices {
  static List<ColorChoice> choices = [
    ColorChoice(
      primary: Color(0xFFF77B67),
      gradient: [
        Color.fromRGBO(245, 68, 113, 1.0),
        Color.fromRGBO(245, 161, 81, 1.0),
      ],
    ),
    ColorChoice(
      primary: Color(0xFF5A89E6),
      gradient: [
        Color.fromRGBO(77, 85, 225, 1.0),
        Color.fromRGBO(93, 167, 231, 1.0),
      ],
    ),
    ColorChoice(
      primary: Color(0xFF4EC5AC),
      gradient: [
        Color.fromRGBO(61, 188, 156, 1.0),
        Color.fromRGBO(61, 212, 132, 1.0),
      ],
    ),
  ];
}
