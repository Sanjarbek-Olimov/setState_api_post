class Employee {
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;
  String? profileImage;

  Employee({this.id, this.employeeName, this.employeeSalary, this.employeeAge, this.profileImage});

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        employeeName = json['employeeName'],
        employeeSalary = json['employeeSalary'],
        employeeAge = json['employeeAge'],
        profileImage = json['profileImage'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'employeeName': employeeName,
    'employeeSalary': employeeSalary,
    'employeeAge': employeeAge,
    'profileImage': profileImage,
  };
}