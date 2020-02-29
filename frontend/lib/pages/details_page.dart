import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodId = "0";
  DetailsPage(Object params){
    return;
  }
  @override
  Widget build(BuildContext context) {
    /*final tiles = _saved.map(
      (pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    */
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Saved Suggestions'),
      ),
      //body: new ListView(children: divided),
      body: new Text('${this.goodId}'),
    );
  }
}
