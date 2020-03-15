import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FunctionButtonsBlock extends StatelessWidget{
  final List<dynamic> itemsList;
  final Function onJumpTo;

  FunctionButtonsBlock(this.itemsList,this.onJumpTo);


  void addItem(Map<String,Object> item){
    this.itemsList.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return (itemsList == null
          ? const Center(child: const CircularProgressIndicator())
          : new GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 25.0),
              padding: const EdgeInsets.all(10.0),
              itemCount: itemsList.length,
              itemBuilder: (BuildContext context, int index) {
                return new GridTile(
                  footer: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Flexible(
                          child: new SizedBox(
                            height: 16.0,
                            width: 100.0,
                            child: new Text(
                              itemsList[index]["name"],
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ]),
                  child: new Container(
                    height: 500.0,
                    child: new GestureDetector(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: new Row(
                              children: <Widget>[
                                new Stack(
                                  children: <Widget>[
                                    new SizedBox(
                                      child: new Container(
                                        child: new CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 40.0,
                                          child: new Icon(
                                              this.itemsList[index]
                                                  ["icon"],
                                              size: 40.0,
                                              color: itemsList[index]
                                                  ["color"]),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        this.onJumpTo(itemsList[index]["url"]);
                      },
                    ),
                  ),
                );
              },
            )
    );
  }
}
