import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ControlPage(),
    );
  }
}

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double porcentagem = 0.0; 

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
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 200.0,
              width: 700,
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  _buildButtonWithImage(context, 'Garrafa', 'assets/images/garrafa.png'),
                  _buildButtonWithImage(context, 'Telefone', 'assets/images/telefone.png'),
                  _buildButtonWithImage(context, 'Pote', 'assets/images/pote.png'),
                  _buildButtonWithImage(context, 'Medicamento', 'assets/images/medicamento.png'),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                print('Movendo Robô');
              },
              child: const Text('Mover Robô'),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Porcentagem: '),
                Slider(
                  value: porcentagem,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() {
                      porcentagem = value;
                      print('Porcentagem: $porcentagem');
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                print('Finalizando');
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
            print('Selecionado: $buttonText');
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
