import 'package:cotacao_moeda/views/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void login() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => Home())
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: ElevatedButton(
                  child: Text('Entrar'),
                  onPressed: login,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
