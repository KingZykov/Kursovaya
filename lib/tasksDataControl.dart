import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class tasksDataControl{
  static const dataKey = 'tasksData';
  static var _tasks=[];
  static int tid=1;
  static int status=0;

  dataInit() async{
    if (status == 0) {
      _tasks = json.decode(await _getData());
    }
    status=1;
  }

  GetItem(int i){
    return _tasks[i];
  }

  GetTID(){
    return tid;
  }

  IncreaseTID(){
    tid++;
  }

  GetItemByUID(int uid){
    for (int i=0; i<_tasks.length; i++){
      if (_tasks[i]["uid"] == uid)
        return _tasks[i];
    }
  }

  GetItemByTID(int tid){
    for (int i=0; i<_tasks.length; i++){
      if (_tasks[i]["tid"] == tid)
        return _tasks[i];
    }
  }

  Future deleteItem(int tid) async{
    _tasks.removeWhere((item) => item["tid"] == tid);
  }

  int getLength(){
    return _tasks.length;
  }

  Future addItem(int tid, int uid, String customer, String product, String quantity, String deadline, String status) async{
    Map Item={"tid":tid, "uid":uid, "customer":customer, "product":product, "quantity":quantity, "deadline":deadline, "status":status};
    _tasks.add(Item);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dataKey, jsonEncode(_tasks));
  }

  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dataKey) ?? "[]";
  }

  void saveItem(int tid, String customer, String product, String quantity, String deadline, String status){
    Map Item={"customer":customer, "product":product, "quantity":quantity, "deadline":deadline, "status":status};
    GetItemByTID(tid)["customer"]=customer;
    GetItemByTID(tid)["product"]=product;
    GetItemByTID(tid)["quantity"]=quantity;
    GetItemByTID(tid)["deadline"]=deadline;
    GetItemByTID(tid)["status"]=status;
  }

  void printData(){
    print("");
    print("tasks:");
    print(_tasks);
  }

  Future getStringInfo(String Key) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.getString(Key) ?? "";
  }

  Future setStringInfo(String Key, String Value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Key, Value);
  }

}
