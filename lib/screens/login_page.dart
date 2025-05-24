import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Material(
          child: Container(
            padding: EdgeInsets.all(15),
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
            ),
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                          
                  children: [
                    Text('Login',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w900),),
                    SizedBox(height: 100,),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter password'
                          : null,
                      onSaved: (value) => password = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                          
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
