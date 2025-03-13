import 'package:flutter/material.dart';
import 'package:shoppinglist_app/widgets/textformdeco.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null ||
      value.isEmpty ||
      value.trim().length <= 1 ||
      value.trim().length > 50) {
    return 'Must be between 1 and 50 character';
  }

  return null;
}

String? validateMobileNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mobile number is required';
  }
  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    return 'Enter a valid 10-digit mobile number';
  }
  return null;
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _saveItem() {
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration Form'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Register'),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              label: const Text('first name'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Enter first Name',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                            ),
                            validator: validateName,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormDeco(
                            lableText: 'last name',
                            hintText: 'Last Name',
                            icons: const Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            validator: validateName,
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormDeco(
                            lableText: 'Email',
                            hintText: 'Email',
                            icons: const Icon(
                              Icons.email,
                              color: Colors.green,
                            ),
                            inputType: TextInputType.text,
                            validator: validateEmail,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormDeco(
                            lableText: 'Phone No',
                            hintText: 'Phone no',
                            icons: const Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            inputType: TextInputType.number,
                            validator: validateMobileNumber,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: _saveItem,
                              child: const Text('Submit '),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
