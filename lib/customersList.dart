import 'package:flutter/material.dart';
import 'customersDataControl.dart';
import 'usersDataControl.dart';
var cid = 0;
var uid = 0;
var dividerIsNeeded = false;
var fio;

class customersList extends StatelessWidget {
  var _value;
  usersDataControl dc = new usersDataControl();
  customersDataControl dcC = new customersDataControl();
  final _biggerFont = const TextStyle(fontSize: 28.0);
  customersList({var value}):_value = value;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        leading: Container(),
        title: Text("Список клиентов"),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dcC.getLength()*2,
        itemBuilder: (BuildContext context, int position){
          if (position.isEven) {
            final li = position ~/ 2;
              return _listRow(context, li);
          }
          return Divider(height: 0, color: Colors.black,  thickness: 0,);
        },
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "tag1",
            onPressed: () {btnPress(context);},
            label: Text("Добавить клиента"),
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
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white,
            elevation: 10,
          ),
        ],
      ),

    );
  }

  Widget _listRow(BuildContext context, int i){
    return ListTile(
        title:
        Text('${dcC.GetItem(i)['FIO']}     ${dcC.GetItem(i)['phoneNumber']}', style: _biggerFont),
        onTap: () {
          cid = dcC.GetItem(i)["cid"];
          Navigator.pushNamed(context, "/elementFormCustomersEdit/$cid");
        }
    );
  }

  btnPress(BuildContext context){
    dcC.IncreaseCID();
    cid = dcC.GetCID();
    uid = int.parse(_value);
    dc.SetCurrentUID(uid);
    fio="Имя Фамилия Отчество";
    dcC.addItem(cid, uid, fio, "8-900-000-00-00", "pochta@mail.ru", "-");
    Navigator.pushNamed(context, "/elementFormCustomers/$cid");
  }
}
