import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VersaDesafioLogo extends StatelessWidget {
  const VersaDesafioLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 90,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text('Versa Desafio',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 22, 127, 212),
                    )),
          ],
        ));
  }
}
