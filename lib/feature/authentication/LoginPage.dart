import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'ChatPage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../main_page/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool saving = false;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: saving,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      saving = true;
                    });
                    try {
                      final currentUser =
                          await _authentication.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (currentUser.user != null) {
                        _formKey.currentState!.reset();
                        Navigator.pushReplacement(
                          // 페이지 전환
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      }
                    } catch (error) {
                      print(error);
                      // 에러 처리 로직 (예: 사용자에게 메시지 표시)
                    } finally {
                      setState(() {
                        saving = false;
                      });
                    }
                  },
                  child: const Text('Enter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('If you did not register, '),
                  TextButton(
                    child: Text('Register your email'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
