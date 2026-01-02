class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? schoolCode;
  final String? teacherCode;
  final String? mobileNumber;
  final String? city;
  final String? state;
  final String? address;
  final int? credits;
  final bool? disabled;
  final String? createdAt;
  final String? rollNumber;
  final String? className;
  final String? sectionName;
  final String? fatherName;
  final String? motherName;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.schoolCode,
    this.teacherCode,
    this.mobileNumber,
    this.city,
    this.state,
    this.address,
    this.credits,
    this.disabled,
    this.createdAt,
    this.rollNumber,
    this.className,
    this.sectionName,
    this.fatherName,
    this.motherName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      schoolCode: json['school_code'],
      teacherCode: json['teacher_code'],
      mobileNumber: json['mobile_number'],
      city: json['city'],
      state: json['state'],
      address: json['address'],
      credits: json['credits'],
      disabled: json['disabled'],
      createdAt: json['created_at'],
      rollNumber: json['roll_number'],
      className: json['class_name'],
      sectionName: json['section_name'],
      fatherName: json['father_name'],
      motherName: json['mother_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'school_code': schoolCode,
      'teacher_code': teacherCode,
      'mobile_number': mobileNumber,
      'city': city,
      'state': state,
      'address': address,
      'credits': credits,
      'disabled': disabled,
      'created_at': createdAt,
      'roll_number': rollNumber,
      'class_name': className,
      'section_name': sectionName,
      'father_name': fatherName,
      'mother_name': motherName,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? role,
    String? schoolCode,
    String? teacherCode,
    String? mobileNumber,
    String? city,
    String? state,
    String? address,
    int? credits,
    bool? disabled,
    String? createdAt,
    String? rollNumber,
    String? className,
    String? sectionName,
    String? fatherName,
    String? motherName,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      schoolCode: schoolCode ?? this.schoolCode,
      teacherCode: teacherCode ?? this.teacherCode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      city: city ?? this.city,
      state: state ?? this.state,
      address: address ?? this.address,
      credits: credits ?? this.credits,
      disabled: disabled ?? this.disabled,
      createdAt: createdAt ?? this.createdAt,
      rollNumber: rollNumber ?? this.rollNumber,
      className: className ?? this.className,
      sectionName: sectionName ?? this.sectionName,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
    );
  }
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String message;
  final SchoolInfo? school;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
    this.school,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'] as String?;
    final refreshToken = json['refreshToken'] as String?;
    
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Invalid response: accessToken is missing');
    }
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('Invalid response: refreshToken is missing');
    }
    
    return LoginResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      message: json['message'] as String? ?? 'Login successful',
      school: json['school'] != null ? SchoolInfo.fromJson(json['school'] as Map<String, dynamic>) : null,
    );
  }
}

class SchoolInfo {
  final String name;
  final String code;

  SchoolInfo({
    required this.name,
    required this.code,
  });

  factory SchoolInfo.fromJson(Map<String, dynamic> json) {
    return SchoolInfo(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

class RegisterRequest {
  final String email;
  final String name;
  final String? password;
  final String? mobileNumber;
  final String userRole;
  final String? schoolCode;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? principalName;
  final String? teacherCode;
  final String? subject;
  final String? rollNumber;
  final String? className;
  final String? sectionName;
  final String? fatherName;
  final String? motherName;

  RegisterRequest({
    required this.email,
    required this.name,
    this.password,
    this.mobileNumber,
    this.userRole = 'INDIVIDUAL',
    this.schoolCode,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.principalName,
    this.teacherCode,
    this.subject,
    this.rollNumber,
    this.className,
    this.sectionName,
    this.fatherName,
    this.motherName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'emailId': email,
      'name': name,
      'userRole': userRole,
    };
    
    if (password != null) data['password'] = password;
    if (mobileNumber != null) data['mobileNumber'] = mobileNumber;
    if (schoolCode != null) data['schoolCode'] = schoolCode;
    if (address != null) data['address'] = address;
    if (city != null) data['city'] = city;
    if (state != null) data['state'] = state;
    if (postalCode != null) data['postalCode'] = postalCode;
    if (principalName != null) data['principalName'] = principalName;
    if (teacherCode != null) data['teacherCode'] = teacherCode;
    if (subject != null) data['subject'] = subject;
    if (rollNumber != null) data['rollNumber'] = rollNumber;
    if (className != null) data['className'] = className;
    if (sectionName != null) data['sectionName'] = sectionName;
    if (fatherName != null) data['fatherName'] = fatherName;
    if (motherName != null) data['motherName'] = motherName;
    
    return data;
  }
}
