import 'package:flutter/material.dart';
import 'package:shoppinglist_app/model/login.dart';
import 'package:http/http.dart' as http;

class LoginData extends StatelessWidget {
  // const LoginData({required this.login});
  // final Login login;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void _loadData() async {
      final url = Uri.https(
          'login-prep-ec492-default-rtdb.firebaseio.com', 'login.json');

      final response = await http.get(url);
      print(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text('text'))],
      ),
    );
  }
}
