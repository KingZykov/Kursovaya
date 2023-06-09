import 'dart:js';
import 'package:flutter/material.dart';
import 'RestartWidget.dart';
import 'usersDataControl.dart';
import 'authControl.dart';

var uid;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  authControl ac = new authControl();
  bool showErrorMessage = false; // Состояние для отображения сообщения об ошибке

  @override
  Widget build(BuildContext context) {
    return showAuthForm(context);
  }

  Widget showAuthForm(BuildContext context) {
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
        child: _buildContent(context, loginController, paswController, _formKey),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TextEditingController loginController,
      TextEditingController paswController, GlobalKey<FormState> _formKey) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (showErrorMessage) // Проверяем флаг, чтобы отображать или скрывать сообщение об ошибке
            Text(
              "Неправильный логин или пароль. Повторите попытку.",
              style: TextStyle(color: Colors.red),
            ),

          SizedBox(height: 10),

          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face),
              hintText: "Логин",
            ),
            controller: loginController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Логи не заполнен";
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
              prefixIcon: Icon(Icons.password),
              hintText: "Пароль",
            ),
            controller: paswController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Пароль не заполнен";
              }
              if (value.length < 3) {
                return "Пароль должен содержат 3 символа";
              }
              return null;
            },
          ),

          SizedBox(height: 10),

          ElevatedButton(
            child: Text('Логин'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                checkLogin(loginController.text, paswController.text, context);
                RestartWidget.restartApp(context);
              }
            },
          ),

          SizedBox(height: 10),

          ElevatedButton(
            child: Text('Регистрация'),
            onPressed: () {
              dc.IncreaseUID();
              uid = dc.GetUID();
              dc.addItem(uid, loginController.text, paswController.text, "name", "surname");
              Navigator.pushNamed(context, "/elementForm/$uid");
            },
          ),

          SizedBox(height: 10),


        ],
      ),
    );
  }

  usersDataControl dc = new usersDataControl();

  void checkLogin(String login, String pasw, BuildContext context) {
    String res = dc.checkUser(login, pasw);
    if (res != "") {
      ac.makeAuth(res);
      uid = dc.GetItemByLogin(login)["uid"];
      Navigator.pushNamed(context, '/menu/$uid');
    } else {
      setState(() {
        showErrorMessage = true; // Устанавливаем флаг, чтобы показать сообщение об ошибке
      });
    }
  }
}
