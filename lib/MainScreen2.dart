import 'dart:js';
import 'package:flutter/material.dart';
import 'RestartWidget.dart';
import 'usersDataControl.dart';
import 'authControl.dart';

var uid;

class MainScreen2 extends StatelessWidget {
  authControl ac = new authControl();

  @override
  Widget build(BuildContext context) {
    return showAuthForm(context);
  }

  Widget showAuthForm(BuildContext context){
    final TextEditingController loginController = TextEditingController();
    final TextEditingController paswController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        leading: Container(),
        title: Text("Авторизация"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(context),
      ),
    );
  }
  Widget _buildContent(BuildContext context) {
    final TextEditingController loginController = TextEditingController();
    final TextEditingController paswController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Вы зарегистрированы. Теперь вы можете войти на сайт под своим логином и паролем",
                style: TextStyle(color: Colors.green)),
            SizedBox(height: 10),

            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.manage_accounts),
                  hintText: "Логин"
              ),
              controller: loginController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Логин не заполнен";
                }
                if (value.length < 3) {
                  return "Логин должен содержать 3 символа";
                }
                return null;
              },
            ),
            SizedBox(height: 10),

            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password_sharp),
                  hintText: "Пароль"
              ),
              controller: paswController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Пароль не заполнен";
                }
                if (value.length < 3) {
                  return "Пароль должен содержать 3 символа";
                }
                return null;
              },
            ),

            SizedBox(height: 10),

            ElevatedButton(
              child: Text('Логин'),
              onPressed: ()=>{
                checkLogin(loginController.text, paswController.text, context),
                RestartWidget.restartApp(context),
              },
            ),

            SizedBox(height: 10),

            ElevatedButton(
              child: Text('Регистрация'),
              onPressed: ()=>{
                dc.IncreaseUID(),
                uid = dc.GetUID(),
                dc.addItem(uid, loginController.text, paswController.text, "name", "surname"),
                Navigator.pushNamed(context, "/elementForm/$uid"),
              },
            ),

          ],
        )
    );
  }
  usersDataControl dc = new usersDataControl();
  void checkLogin(String login, String pasw, BuildContext context){
    String res = dc.checkUser(login, pasw);
    if(res!=""){
      ac.makeAuth(res);
      uid = dc.GetItemByLogin(login)["uid"];
      Navigator.pushNamed(context, '/menu/$uid');
    }
    else {
      Navigator.pushNamed(context, '/3');
    }
  }

}



