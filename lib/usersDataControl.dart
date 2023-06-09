import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class usersDataControl{
  static const dataKey = 'usersData';
  static var _users=[];
  static int status=0;
  static int uid=9;
  static int currentuid=-1;

  IncreaseUID(){
    uid++;
  }

  SetCurrentUID(currentUID){
    currentuid = currentUID;
  }

  GetCurrentUID(){
    return currentuid;
  }

  GetUID(){
    return uid;
  }

  dataInit() async{
    if (status == 0) {
       _users = json.decode(await _getData());
    }
    status=1;
  }

  GetItem(int i){
    return _users[i];
  }

  GetItemByUID(int uid){
    for (int i=0; i<_users.length; i++){
      if (_users[i]["uid"] == uid)
        return _users[i];
    }
  }

  GetItemByLogin(String login){
    for (int i=0; i<_users.length; i++){
      if (_users[i]["login"] == login)
        return _users[i];
    }
  }

  int getLength(){
    return _users.length;
  }

  String checkLogin (String login){
    int i;
    for (i=0; i<_users.length; i++){
      if (_users[i]["login"]==login) return _users[i]["login"];
    }
    return "";
  }

  String checkUser (String login, String pasw){
    int i;
    for (i=0; i<_users.length; i++){
      if (_users[i]["login"]==login && _users[i]["pasw"]==pasw) return _users[i]["login"];
    }
    return "";
  }

  Future addItem(int uid, String login, String pasw, String name, String surname) async{
      Map Item={"uid":uid, "login":login, "pasw":pasw, "name":name, "surname":surname};
      _users.add(Item);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(dataKey, jsonEncode(_users));
  }

  Future<String> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dataKey) ?? "[]";
  }

  void saveItem(int uid, String login, String pasw, String name, String surname){
    Map Item={"uid":uid, "login":login, "pasw":pasw, "name":name, "surname":surname};
    GetItemByUID(uid)["login"]=login;
    GetItemByUID(uid)["pasw"]=pasw;
    GetItemByUID(uid)["name"]=name;
    GetItemByUID(uid)["surname"]=surname;
  }

  void printData(){
    print("");
    print("users:");
    print(_users);
  }

  Future getStringInfo(String Key) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.getString(Key) ?? "";
  }

  Future setStringInfo(String Key, String Value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Key, Value);
  }

  Future deleteItem(int uid) async{
    _users.removeWhere((item) => item["uid"] == uid);
  }

}
