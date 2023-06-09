 import 'package:flutter/material.dart';
import 'usersDataControl.dart';
import 'tasksDataControl.dart';
import 'customersDataControl.dart';
import 'dart:async';

class taskAddForm extends StatefulWidget {
  @override
  var _value;

  taskAddForm({var value}):_value = value;

  _elementFormState createState() => _elementFormState();
  getValue(){
    return _value;
  }
}

class _elementFormState extends State<taskAddForm> {
  var uid;
  usersDataControl dc = new usersDataControl();
  tasksDataControl dc2 = new tasksDataControl();
  customersDataControl dcC = new customersDataControl();
  var typeOfEditing = "";

  String? selectedCustomer;
  List<String> listOfCustomers = [];

  String? selectedProduct;
  List<String> listOfProducts = ['Пюре Картофельное С Котлетой', 'Обед', 'Зелёный Чай', 'Торт Черепаха'];

  List<String> statusOptions = ['Создан', 'Обработан', 'Оплачен', 'Выполнен'];
  String? selectedStatus;

  final TextEditingController customerController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  DateTime? selectedDate; // Добавлено для хранения выбранной даты

  void initState(){
    super.initState();

    dcC = customersDataControl(); // Создание экземпляра dcC

    if (widget._value != null){
      var item = dc2.GetItemByTID(int.parse(widget._value));
      customerController.text = item['customer'];
      productController.text = item['product'];
      quantityController.text = '';
      selectedDate = DateTime.parse(item['deadline']); // Установка выбранной даты
      selectedStatus = item['status'];
      typeOfEditing = "Сохранить";
    } else {
      typeOfEditing = "Новый";
    }

    initializeA(); // Вызов метода initializeA() для заполнения списка listOfCustomers
  }

  void initializeA() {
    listOfCustomers = dcC.returnFIOsOfCustomers(); // Присваивание значений из dcC.returnFIOsOfCustomers()
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
        title: Text("Добавить задачи"),
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
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: "Клиент",
              ),
              value: selectedCustomer,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCustomer = newValue;
                });
              },
              items: listOfCustomers.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                print(listOfCustomers);
                if (listOfCustomers.isEmpty) {
                  return "Нет зарегистрированных клиентов. Перед созданием задачи необходимо зарегистрировать хотя бы одного клиента";
                }
                if (value == null || value.isEmpty) {
                  return "Поле Клиент не заполнено";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.production_quantity_limits_sharp),
              hintText: "Продукт",
            ),
            value: selectedProduct,
            onChanged: (String? newValue) {
              setState(() {
                selectedProduct = newValue;
              });
            },
            items: listOfProducts.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Поле Продукт не заполнено";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.numbers),
              hintText: "Количество",
            ),
            controller: quantityController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Поле Количество не заполнено";
              }
              final intValue = int.tryParse(value);
              if (intValue == null || intValue < 1 || intValue > 100) {
                return "Количество должно быть целым числом от 1 до 100.";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            onTap: () {
              _selectDate(context); // Open the date picker dialog
            },
            controller: TextEditingController(
              text: selectedDate != null
                  ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                  : '', // Display the selected date or an empty string
            ),
            readOnly: true, // Disable manual text input
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.date_range),
              hintText: "Срок",
            ),
            validator: (value) {
              if (selectedDate == null) {
                return "Поле срок пусто";
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text(typeOfEditing),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _btnPress();
              }
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text("Удалить"),
            onPressed: _btn2Press,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().add(Duration(days: 1)), // Задайте первую доступную дату - завтрашнюю дату
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _btn2Press(){
    dc2.deleteItem(int.parse(widget._value));
    uid = dc.GetCurrentUID();
    Navigator.pushNamed(context, "/elementList2/$uid");
  }

  void _btnPress(){
    dc2.saveItem(
      int.parse(widget._value),
      selectedCustomer ?? '',
      selectedProduct ?? '',
      quantityController.text,
      selectedDate?.toIso8601String() ?? '', // Сохраняет выбранную дату в формате ISO 8601
      selectedStatus ?? '',
    );
    dc2.printData();
    uid = dc.GetCurrentUID();
    Navigator.pushNamed(context, "/elementList2/$uid");
  }
}
