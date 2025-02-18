class Student {
  int? studentId;
  String? fullName;
  String? dateOfBirth;
  String? gender;
  String? address;
  int? classId;
  String? hk1;  // Conduct grade for the first semester
  String? hk2;  // Conduct grade for the second semester

  Student({
    this.studentId,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.classId,
    this.hk1,
    this.hk2,
  });

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    fullName = json['full_name'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    classId = json['class_id'];
    hk1 = json['hk1'];  // Deserialize the hk1 field
    hk2 = json['hk2'];  // Deserialize the hk2 field
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['full_name'] = fullName;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['address'] = address;
    data['class_id'] = classId;
    data['hk1'] = hk1;  // Serialize the hk1 field
    data['hk2'] = hk2;  // Serialize the hk2 field
    return data;
  }
}
