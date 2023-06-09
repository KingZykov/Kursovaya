import 'package:flutter/material.dart';
import 'tasksDataControl.dart';
import 'usersDataControl.dart';
var sid = 0;
var uid = 0;
var dividerIsNeeded = false;
var date2;

class menu extends StatelessWidget {
  var _value;
  usersDataControl dc = new usersDataControl();
  tasksDataControl dc2 = new tasksDataControl();
  final _biggerFont = const TextStyle(fontSize: 28.0);
  menu({var value}):_value = value;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(automaticallyImplyLeading: false, leading: Container(), title: Text('Здравствуй, ${dc.GetItemByUID(int.parse(_value))['name']}!'),
        backgroundColor: Colors.greenAccent,
      actions: <Widget>[
        // IconButton(onPressed: null, icon: Icon(Icons.account_box)),
        IconButton(onPressed: (){
          // print("1");
          Navigator.pushNamed(context, "/elementForm1/$_value");
        }, icon: Icon(Icons.account_circle)),
      ],
      ),
      body: Center(child: Column(children: [

        SizedBox(height: 30),

        ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/elementListCustomers/$_value');
          // print("${dc.GetItemByUID(int.parse(_value))['name']}");
        },
            child: Text('Список клиентов')),

        SizedBox(height: 20),

        ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/elementList2/$_value');
        },
            child: Text('Список задач пользователя')),

        SizedBox(height: 20),

        ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/');
        },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,),
            child: Text('Выйти')),

      ],)),
    );
  }


}
