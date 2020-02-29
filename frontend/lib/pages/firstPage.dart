import 'package:flutter/material.dart';
import '../store/model/UserModel.dart';
import '../store/model/CounterModel.dart';
import '../application.dart';
import '../store/index.dart';

class FirstPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('first page rebuild');
    return Scaffold(
      appBar: AppBar(title: Text('FirstPage'),),
      body: Center(
        child: Column(
          children: <Widget>[
            Store.connect<Counter>(
              builder: (context, snapshot, child) {
                return RaisedButton(
                  child: Text('+'),
                  onPressed: () {
                    snapshot.increment();
                  },
                );
              }
            ),
            Store.connect<Counter>(
              builder: (context, snapshot, child) {
                print('first page counter widget rebuild');
                return Text(
                  '${snapshot.count}'
                );
              }
            ),
            Store.connect<Counter>(
              builder: (context, snapshot, child) {
                return RaisedButton(
                  child: Text('-'),
                  onPressed: () {
                    snapshot.decrement();
                  },
                );
              }
            ),
            Store.connect<UserModel>(
              builder: (context, snapshot, child) {
                print('first page name Widget rebuild');
                return Text(
                  '${Store.value<UserModel>(context).name}'
                );
              }
            ),
            TextField(
              controller: controller,
            ),
            Store.connect<UserModel>(
              builder: (context, snapshot, child) {
                return RaisedButton(
                  child: Text('change name'),
                  onPressed: () {
                    snapshot.setName(controller.text);
                  },
                );
              }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Icon(Icons.group_work)
        ),
        onPressed: () {
          Application.router.navigateTo(context,"/secondPage?id=555");
          /*
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
              return SecondPage();
          }));
          */
        },
      ),
    );
  }
}