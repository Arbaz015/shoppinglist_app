import 'package:flutter/material.dart';
import 'package:shoppinglist_app/model/login.dart';

class LoginData extends StatelessWidget {
  const LoginData({required this.login});
  final Login login;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text(login.fName))],
      ),
    );
  }
}
