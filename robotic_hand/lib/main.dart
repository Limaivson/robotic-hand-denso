import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle do Robô'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildButtonWithImage(context, 'Garrafa', 'garrafa.png'),
                  _buildButtonWithImage(context, 'Telefone', 'telefone.png'),
                  _buildButtonWithImage(context, 'Pote', 'pote.png'),
                  _buildButtonWithImage(context, 'Medicamento', 'medicamento.png'),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para mover o robô
              },
              child: const Text('Mover Robô'),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Porcentagem: '),
                Slider(
                  value: 50,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    // Lógica para atualizar a porcentagem
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para finalizar
              },
              child: const Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonWithImage(BuildContext context, String buttonText, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Lógica para o botão
          },
          child: Text(buttonText),
        ),
        const SizedBox(height: 10.0),
        Image.asset(
          imagePath,
          height: 100.0,
          width: 100.0,
        ),
      ],
    );
  }
}
