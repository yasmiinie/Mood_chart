import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailConroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var _isNotValide = false;

  void signIn() async {
    if ((emailConroller.text.isEmpty) || (passwordController.text.isEmpty)) {
      _isNotValide = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const Text("data"),
              TextField(
                controller: emailConroller,
                decoration: InputDecoration(
                    errorText: _isNotValide ? "write down" : null,
                    errorStyle: TextStyle(color: Colors.amber)),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    errorText: _isNotValide ? "write down" : null,
                    errorStyle: TextStyle(color: Colors.amber)),
              ),
              TextButton(
                  onPressed: () {
                    print(emailConroller.text);
                    setState(() {
                      signIn();
                    });
                  },
                  child: Text("press"))
            ],
          ),
        ),
      ),
    );
  }
}
