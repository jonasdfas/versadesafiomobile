import 'dart:convert';
import 'dart:math';

import 'package:desafio_mobile/%20home_page.dart';
import 'package:desafio_mobile/core/widget/backgroundwidget.dart';
import 'package:desafio_mobile/core/widget/decoracao_input.dart';
import 'package:desafio_mobile/core/widget/versa_desafio_logo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey =
      GlobalKey<FormState>(); // validade se algum dado foi inserido errado
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'), // Caminho da imagem
          fit: BoxFit.cover, // Ajusta a imagem para cobrir a tela inteira
        ),
      ),
      child: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VersaDesafioLogo(),
                const SizedBox(height: 19),
                TextFormField(
                  //user
                  decoration: getAutenticacaoinputdecoration("Usuario"),
                  controller: _userController,
                  keyboardType:
                      TextInputType.text, //controla o teclado que sera exibido
                  validator: (user) {
                    if (user == null || user.isEmpty) {
                      return 'Por favor, Digite seu usuario ai amigo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  //senha
                  decoration: getAutenticacaoinputdecoration(
                      "Senha"), //placeholder do input
                  obscureText: true, //esconder a senha
                  controller: _passwordController,
                  keyboardType: TextInputType.text, // tipo do teclado
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Digita sua senha ai meu amigo';
                    } else if (senha.length < 8) {
                      return ' por favor digita sua senha maior de 8 caractres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    FocusScopeNode cureentFocus = FocusScope.of(context);
                    if (_formkey.currentState!.validate()) {
                      bool deuCertoentra = await login();
                      if (!cureentFocus.hasPrimaryFocus) {
                        cureentFocus.unfocus();
                      }
                      if (deuCertoentra) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(),
                          ),
                        );
                      } else {
                        _passwordController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } // vai validar se os dados estao certo antes de rfazer a requisao
                  },
                  child: Text('Entra'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // mensagem de erro no login
  final snackBar = SnackBar(
    content: Text(
      'Usuário ou senha  estão inválidos',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url =
        Uri.parse('https://homologa.versasaude.com.br/apiPassport/v1/login');
    var resposta = await http.post(
      url,
      body: {
        'login': _userController.text,
        'password': _passwordController.text
      },
    );
    if (resposta.statusCode == 200) {
      await sharedPreferences.setString(
          'token', "Token ${jsonDecode(resposta.body)['token']})");
      return true;
    } else {
      print(jsonDecode(resposta.body));
      return false;
    }
  }
}
