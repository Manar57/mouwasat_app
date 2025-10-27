class User {
  final String id;
  final String governmentId;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? nationality;
  final String? hospital;
  final String? birthDate;
  final String? maritalStatus;
  final String? religion;
  final DateTime? createdAt;
  final String currentSessionId;
  final String? deviceId;

  User({
    required this.id,
    required this.governmentId,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.nationality,
    this.hospital,
    this.birthDate,
    this.maritalStatus,
    this.religion,
    this.createdAt,
    required this.currentSessionId,
    this.deviceId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'governmentId': governmentId,
    'email': email,
    'name': name,
    'phoneNumber': phoneNumber,
    'nationality': nationality,
    'hospital': hospital,
    'birthDate': birthDate,
    'maritalStatus': maritalStatus,
    'religion': religion,
    'createdAt': createdAt?.toIso8601String(),
    'currentSessionId': currentSessionId,
    'deviceId': deviceId,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    governmentId: json['governmentId'],
    email: json['email'],
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    nationality: json['nationality'],
    hospital: json['hospital'],
    birthDate: json['birthDate'],
    maritalStatus: json['maritalStatus'],
    religion: json['religion'],
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    currentSessionId: json['currentSessionId'],
    deviceId: json['deviceId'],
  );
}

class UserCredentials {
  final String governmentId;
  final String password;
  final DateTime savedAt;
  final String? deviceId;

  UserCredentials({
    required this.governmentId,
    required this.password,
    required this.savedAt,
    this.deviceId,
  });

  Map<String, dynamic> toJson() => {
    'governmentId': governmentId,
    'password': password,
    'savedAt': savedAt.toIso8601String(),
    'deviceId': deviceId,
  };

  factory UserCredentials.fromJson(Map<String, dynamic> json) => UserCredentials(
    governmentId: json['governmentId'],
    password: json['password'],
    savedAt: DateTime.parse(json['savedAt']),
    deviceId: json['deviceId'],
  );
}


