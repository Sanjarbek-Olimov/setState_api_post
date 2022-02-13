import 'package:flutter/material.dart';
import 'package:networking/model/employee_model.dart';
import '../service/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? data = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Employee employee = Employee(id: 18, employeeName: "Sanjarbek", employeeAge: 25, employeeSalary: 1000000, profileImage: "qwerty");
    _apiEmployeesList();
    // _apiOneEmployee(employee.id!);
    // _apiCreateEmployee(employee);
    // _apiUpdateEmployee(employee);
    // _apiDeleteEmployee(employee);
  }

  void _apiEmployeesList(){
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response!)
    });
  }

  void _apiOneEmployee(int id){
    Network.GET(Network.API_ONE_ELEMENT+id.toString(), Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response!)
    });
  }

  void _apiCreateEmployee(Employee employee){
    Network.POST(Network.API_CREATE, Network.paramsCreate(employee)).then((response) =>
    {
      _showResponse(response!)
    });
  }

  void _apiUpdateEmployee(Employee employee){
    Network.PUT(Network.API_UPDATE+employee.id.toString(), Network.paramsUpdate(employee)).then((response) =>
    {
      _showResponse(response!)
    });
  }

  void _apiDeleteEmployee(Employee employee){
    Network.DEL(Network.API_DELETE+employee.id.toString(), Network.paramsEmpty()).then((response) =>
    {
      _showResponse(response!)
    });
  }

  void _showResponse(String response){
    setState(() {
      data=response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("HTTP Networking"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(data ?? "No data"),
          ),
        ),
      ),
    );
  }
}
