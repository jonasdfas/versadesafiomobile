import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final String imagePath; // Caminho da imagem
  final Widget child; // Conteúdo a ser exibido sobre o plano de fundo

  const BackgroundWidget({
    Key? key,
    required this.imagePath,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath), // Caminho da imagem
          fit: BoxFit.cover, // Faz a imagem cobrir toda a tela
        ),
      ),
      child: child, // Adiciona o conteúdo sobre o fundo
    );
  }
}
