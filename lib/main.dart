import 'package:flutter/material.dart';
import 'package:start_prj_3/authControl.dart';
import 'userEditForm.dart';
import 'taskAddForm.dart';
import 'taskEditForm.dart';
import 'customerAddForm.dart';
import 'customerEditForm.dart';
import 'tasksList.dart';
import 'customersList.dart';
import 'usersDataControl.dart';
import 'MainScreen.dart';
import 'MainScreen2.dart';
import 'userRegisterForm.dart';
import 'menu.dart';

void main() {

  usersDataControl dc = new usersDataControl();
  authControl ac = new authControl();
  ac.dataInit();
  dc.dataInit();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => MainScreen(),
      '/2': (BuildContext context) => MainScreen2(),
      '/elementForm': (BuildContext context) => userRegisterForm(),
      '/elementForm1': (BuildContext context) => userEditForm(),
      '/menu': (BuildContext context) => menu(),
      '/elementListCustomers': (BuildContext context) => customersList(),
      '/elementFormCustomers': (BuildContext context) => customerAddForm(),
    },
    onGenerateRoute: (routeSettings){
      var path=[];
      String rname = routeSettings.name.toString();
      path = rname.split('/');
      if (path[1]=='elementList2'){
        return new MaterialPageRoute(
          builder: (context)=>new tasksList(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementForm'){
        return new MaterialPageRoute(
          builder: (context)=>new userRegisterForm(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementForm1'){
        return new MaterialPageRoute(
          builder: (context)=>new userEditForm(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementForm2'){
        return new MaterialPageRoute(
          builder: (context)=>new taskAddForm(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='menu'){
        return new MaterialPageRoute(
          builder: (context)=>new menu(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementListCustomers'){
        return new MaterialPageRoute(
          builder: (context)=>new customersList(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementFormCustomers'){
        return new MaterialPageRoute(
          builder: (context)=>new customerAddForm(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementFormCustomersEdit'){
        return new MaterialPageRoute(
          builder: (context)=>new customerEditForm(value:path[2]),
          settings: routeSettings,
        );
      };
      if (path[1]=='elementForm2Edit'){
        return new MaterialPageRoute(
          builder: (context)=>new taskEditForm(value:path[2]),
          settings: routeSettings,
        );
      };
    },

  ));
}