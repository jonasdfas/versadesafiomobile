import 'package:desafio_mobile/%20home_page.dart';
import 'package:desafio_mobile/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoasvindasPage extends StatefulWidget {
  const BoasvindasPage({super.key});

  @override
  State<BoasvindasPage> createState() => _BoasvindasPage();
}

class _BoasvindasPage extends State<BoasvindasPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificarToken().then((value){
      if(value){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => home(),
          ),
        );
        // pushReplacement PASSA para proxima pagina e exclui a anterior
      }else{
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
          ),
        );
        // pushReplacement PASSA para proxima pagina e exclui a anterior

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> verificarToken() async {
    // verificar se há um token ou não
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}
