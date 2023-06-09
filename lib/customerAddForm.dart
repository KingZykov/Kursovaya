import 'package:flutter/material.dart';
import 'usersDataControl.dart';
import 'customersDataControl.dart';

class customerAddForm extends StatefulWidget {
  @override
  var _value;

  customerAddForm({var value}):_value = value;

  _elementFormState createState() => _elementFormState();
  getValue(){
    // print("_value = ${_value}");
    return _value;
  }

}

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp phoneRegex = RegExp(r'^8-9\d{2}-\d{3}-\d{2}-\d{2}$');
  return phoneRegex.hasMatch(phoneNumber);
}

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  return emailRegex.hasMatch(email);
}

bool isAlphaWithSpaces(String value) {
  final alphaRegex = RegExp(r'^[a-zA-ZА-Яа-яЁё\s]+$');
  return alphaRegex.hasMatch(value);
}


class _elementFormState extends State<customerAddForm> {
  var uid;
  usersDataControl dc = new usersDataControl();
  customersDataControl dcC = new customersDataControl();
  var typeOfEditing = "";

  final TextEditingController loginController = TextEditingController();
  final TextEditingController paswController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  void initState(){
    super.initState();

    if (widget._value!=null){
      loginController.text = dcC.GetItemByCID(int.parse(widget._value))['FIO'];
      paswController.text = dcC.GetItemByCID(int.parse(widget._value))['phoneNumber'];
      subjectController.text = dcC.GetItemByCID(int.parse(widget._value))['email'];
      infoController.text = dcC.GetItemByCID(int.parse(widget._value))['info'];
      typeOfEditing = "Сохранить";
    }
    else{
      loginController.text='';
      typeOfEditing = "Новый";
    }
    // print(widget._value);
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        leading: Container(),
        title: Text("Добавить клиента"),
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
              prefixIcon: Icon(Icons.person),
              hintText: "ФИО",
            ),
            controller: loginController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "ФИО не заполнено";
              }
              if (!isAlphaWithSpaces(value)) {
                return "ФИО должно разделяться пробелами";
              }
              if (value.length < 10) {
                return "ФИО должно включать 10 символов";
              }
              return null;
            },
          ),
          SizedBox(height: 10),

          TextFormField(
            // obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
              hintText: "Телефон",
            ),
            controller: paswController,
            validator: (value){
              if (value == null || value.isEmpty) {
                return "Телефон не заполнен";
              }
              if (value.length < 11){
                return "Телефон состоит из 11 символов";
              }
              return null;
            },
          ),

          SizedBox(height: 10),

          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              hintText: "Email",
            ),
            controller: subjectController,
            validator: (value){
              if (value == null || value.isEmpty) {
                return "Email не заполнена";
              }
              if (value.length < 10){
                return "Email должен содержать 10 символов";
              }
              return null;
            },
          ),

          SizedBox(height: 10),

          TextFormField(
            minLines: 6,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              labelText: 'Дополнительная информация о клиенте',
            ),
            controller: infoController,
          ),

          SizedBox(height: 10),

          ElevatedButton(
            child: Text(typeOfEditing),
            onPressed: _btnPress,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            // selectionColor: Colors.red ,
              child: Text("удалить", ),
              onPressed: _btn2Press,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,)
          ),
        ],
      ),
    );
  }

  void _btn2Press(){
    dcC.deleteItem(int.parse(widget._value));
    uid = dc.GetCurrentUID();
    Navigator.pushNamed(context, "/elementListCustomers/$uid");
  }

  void _btnPress() {
    if (_formKey.currentState!.validate()) {
      if (!isValidPhoneNumber(paswController.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Неправильный номер телефона"),
              content: Text("Пожалуйста, введите действительный номер телефона в формате: 8-9XX-XXX-XX-XX"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      if (!isValidEmail(subjectController.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Неправильный Email"),
              content: Text("Пожалуйста, введите действительный адрес email"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      // Proceed with saving the data
      if (typeOfEditing == "new") {
        dc.saveItem(
          int.parse(widget._value),
          loginController.text,
          paswController.text,
          subjectController.text,
          infoController.text,
        );
      } else if (typeOfEditing == "Сохранить") {
        dcC.saveItem(
          int.parse(widget._value),
          loginController.text,
          paswController.text,
          subjectController.text,
          infoController.text,
        );
      }

      dcC.printData();
      uid = dc.GetCurrentUID();
      Navigator.pushNamed(context, "/elementListCustomers/$uid");
    }
  }

}








//