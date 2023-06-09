import 'package:flutter/material.dart';
import 'usersDataControl.dart';

class userEditForm extends StatefulWidget {
  var _value;

  userEditForm({var value}) : _value = value;

  @override
  _ElementFormState createState() => _ElementFormState();
}

class _ElementFormState extends State<userEditForm> {
  var uid;
  usersDataControl dc = usersDataControl();
  var typeOfEditing = "";

  final TextEditingController loginController = TextEditingController();
  final TextEditingController paswController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  void initState() {
    super.initState();

    if (widget._value != null) {
      loginController.text = dc.GetItemByUID(int.parse(widget._value))['login'];
      paswController.text = dc.GetItemByUID(int.parse(widget._value))['pasw'];
      nameController.text = dc.GetItemByUID(int.parse(widget._value))['name'];
      surnameController.text = dc.GetItemByUID(int.parse(widget._value))['surname'];
      typeOfEditing = "save";
    } else {
      loginController.text = '';
      typeOfEditing = "save";
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(),
        title: Text("Добавить Пользователя"),
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
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face),
              hintText: "Логин",
            ),
            controller: loginController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Логин не заполнен";
              }
              if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                return "Логин состоит из латиницы и цифр";
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
              if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                return "Пароль содержит только латиницу и цифры";
              }
              if (value.length < 3) {
                return "Пароль должен содержать 3 символа";
              }
              return null;
            },
          ),
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
              if (!RegExp(r'^[A-ZА-ЯЁ][a-zA-ZА-Яа-яЁё]*$').hasMatch(value)) {
                return "Имя должно начинаться с заглавной буквы";
              }
              if (value.length < 3) {
                return "Имя должно содержать не менее 3 символов";
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
              if (!RegExp(r'^[A-ZА-ЯЁ][a-zA-ZА-Яа-яЁё]*$').hasMatch(value)) {
                return "Фамилия должна начинаться с заглавной буквы";
              }
              if (value.length < 3) {
                return "Фамилия должна содержать не менее 3 символов";
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
            child: Text("Меню"),
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
      uid = widget._value;
      Navigator.pushNamed(context, "/menu/$uid");
    }
  }

  void _btnPress2() {
    uid = widget._value;
    Navigator.pushNamed(context, "/menu/$uid");
  }
}
