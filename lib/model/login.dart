import 'dart:ffi';

class Login {
  // Login(
  //     {required this.fName,
  //     required this.lName,
  //     required this.email,
  //     required this.mob});

  String fName = '';
  String lName = '';
  String email = '';
  int mob = 0;

  String get name => fName;

  set firstName(String value) {
    fName = value;
  }

  String get lastName => lName;

  set lastName(String value) {
    lName = value;
  }

  String get userEmail => email;

  set userEmail(String value) {
    email = value;
  }

  int get userMob => mob;

  set userMob(int value) {
    mob = value;
  }
}
