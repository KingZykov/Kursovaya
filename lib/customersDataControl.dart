import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class customersDataControl{
  static const dataKey = 'customersData';
  static var _customers=[];
  static int cid=19;
  static int status=0;

  dataInit() async{
    if (status == 0) {
      _customers = json.decode(await _getData());
    }

    status=1;
  }

  GetItem(int i){
    return _customers[i];
  }

  GetCID(){
    return cid;
  }

  IncreaseCID(){
    cid++;
  }

  GetItemByUID(int uid){
    for (int i=0; i<_customers.length; i++){
      if (_customers[i]["uid"] == uid)
        return _customers[i];
    }
  }

  GetItemByCID(int uid){
    for (int i=0; i<_customers.length; i++){
      if (_customers[i]["cid"] == uid)
        return _customers[i];
    }
  }

  Future deleteItem(int cid) async{
    _customers.removeWhere((item) => item["cid"] == cid);
  }

  int getLength(){
    return _customers.length;
  }

  String checkUser (String login, String pasw){
    int i;
    for (i=0; i<_customers.length; i++){
      if (_customers[i]["login"]==login && _customers[i]["pasw"]==pasw) return _customers[i]["login"];
    }
    return "";
  }

  Future addItem(int cid, int uid, String FIO, String phoneNumber, String email, String info) async{
    Map Item={"cid":cid, "uid":uid, "FIO":FIO, "phoneNumber":phoneNumber, "email":email, "info":info};
    _customers.add(Item);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dataKey, jsonEncode(_customers));
  }

  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dataKey) ?? "[]";
  }

  void saveItem(int cid, String FIO, String phoneNumber, String email, String info){
    Map Item={"FIO":FIO, "phoneNumber":phoneNumber, "email":email};
    GetItemByCID(cid)["FIO"]=FIO;
    GetItemByCID(cid)["phoneNumber"]=phoneNumber;
    GetItemByCID(cid)["email"]=email;
    GetItemByCID(cid)["info"]=info;
  }

  void printData(){
    print("");
    print("customers:");
    print(_customers);
  }

  List<String> returnFIOsOfCustomers(){
    List<String> fioList = _customers.map((item) => item['FIO'] as String).toList();
    return (fioList);
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
