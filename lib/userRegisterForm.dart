import 'package:flutter/material.dart';
import 'usersDataControl.dart';

class userRegisterForm extends StatefulWidget {
  var _value;
  // final int _value;
  userRegisterForm({var value}) : _value = value;

  @override
  _userRegisterFormState createState() => _userRegisterFormState();
}

class _userRegisterFormState extends State<userRegisterForm> {
  usersDataControl dc = new usersDataControl();
  var typeOfEditing = "";

  final TextEditingController loginController = TextEditingController();
  final TextEditingController paswController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  void initState() {
    super.initState();

    if (widget._value != null) {
      loginController.text = dc.GetItemByUID(int.parse(widget._value))['login'];
      typeOfEditing = "Зарегистрировать";
    } else {
      loginController.text = '';
      typeOfEditing = "Зарегистрировать";
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        leading: Container(),
        title: Text("Регистрация"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              hintText: "Имя",
            ),
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Имя не заполнено";
              }
              if (!isEnglishName(value)) {
                return "Имя начинается с заглавной буквы";
              }
              if (value.length < 3) {
                return "Имя должно содержать 3 символа";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              hintText: "Фамилия",
            ),
            controller: surnameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Фамилия не заполнена";
              }
              if (!isEnglishName(value)) {
                return "Фамилия начинается с заглавной буквы";
              }
              if (value.length < 3) {
                return "Фамилия должна содержать 3 символа";
              }
              return null;
            },
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
              String res = dc.checkLogin(value.toString());
              if (res !=""){
                return "Логин уже используется. Выберите другой";
              }
              if (value == null || value.isEmpty) {
                return "Логин не заполнен";
              }
              if (!isAlphaNumeric(value)) {
                return "Логин содержит только из латиницы и цифр";
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
              if (!isAlphaNumeric(value)) {
                return "Пароль содержит только латиницу и цифры";
              }
              if (value.length < 3) {
                return "Пароль должен содержать 3 символа";
              }
              return null;
            },
          ),

          SizedBox(height: 10),
          ElevatedButton(
            child: Text(typeOfEditing),
            onPressed: _btnPress,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text("Авторизация"),
            onPressed: _btnPress2,
          ),
        ],
      ),
    );
  }

  void _btnPress() {
    if (_formKey.currentState!.validate()) {
      dc.saveItem(
        int.parse(widget._value),
        loginController.text,
        paswController.text,
        nameController.text,
        surnameController.text,
      );

      dc.printData();
      Navigator.pushNamed(context, "/2");
    }
  }

  void _btnPress2() {
    dc.deleteItem(int.parse(widget._value));
    Navigator.pushNamed(context, "/");
  }

  bool isAlphaNumeric(String value) {
    final alphaNumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphaNumericRegex.hasMatch(value);
  }

  bool isEnglishName(String value) {
    final englishNameRegex = RegExp(r'^[A-ZА-ЯЁ][a-zA-ZА-Яа-яЁё]*$');
    return englishNameRegex.hasMatch(value);
  }
}
