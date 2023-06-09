import 'package:flutter/material.dart';
import 'tasksDataControl.dart';
import 'usersDataControl.dart';

var tid = 0;
var uid = 0;
var dividerIsNeeded = false;
var date2, date3;

class tasksList extends StatelessWidget {
  var _value;
  usersDataControl dc = new usersDataControl();
  tasksDataControl dc2 = new tasksDataControl();
  final _biggerFont = const TextStyle(fontSize: 28.0);

  tasksList({var value}) : _value = value;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          automaticallyImplyLeading: false,
          leading: Container(),
          title: Text(
              "Перечень задач для клиента ${dc.GetItemByUID(int.parse(_value))['name']}"),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: dc2.getLength() * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isEven) {
              final li = position ~/ 2;
              if (int.parse(_value).toString() ==
                  (dc2.GetItem(li)['uid']).toString()) {
                return _listRow(context, li);
              }
            }
            return Divider(
              height: 0,
              color: Colors.black,
              thickness: 0,
            );
          },
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton.extended(
                onPressed: () {
                  btnPress(context);
                },
                label: Text("Добавить задачу"),
                icon: Icon(Icons.add),
                backgroundColor: Colors.lightGreenAccent,
                foregroundColor: Colors.black54,
                elevation: 10,
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                heroTag: "tag2",
                onPressed: () {
                  uid = int.parse(_value);
                  Navigator.pushNamed(context, "/menu/$uid");
                },
                label: Text("Меню"),
                icon: Icon(Icons.arrow_back),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 10,
              ),
        ])
    );
  }

  Widget _listRow(BuildContext context, int i) {
    return ListTile(
        title:
            Text(
                'task id = ${i}          status = ${dc2.GetItem(i)['status']}',
                style: _biggerFont),
        onTap: () {
          tid = dc2.GetItem(i)["tid"];
          Navigator.pushNamed(context, "/elementForm2Edit/$tid");
        });
  }

  btnPress(BuildContext context) {
    dc2.IncreaseTID();
    tid = dc2.GetTID();
    uid = int.parse(_value);
    dc.SetCurrentUID(uid);
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    DateTime date2 = date.add(Duration(days: 28));
    if (date2.month < 10){
      if (date2.day < 10){
        date3 = "${date2.year}-0${date2.month}-0${date2.day}T12:30:00.000Z";
      }
      else {
        date3 = "${date2.year}-0${date2.month}-${date2.day}T12:30:00.000Z";
      }
    }
    else {
      date3 = "${date2.year}-0${date2.month}-0${date2.day}T12:30:00.000Z";
    }
    dc2.addItem(tid, uid, "customer 1", 'Обед', "10", date3, 'Создан');

    Navigator.pushNamed(context, "/elementForm2/$tid");
  }
}
