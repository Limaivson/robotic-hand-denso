import 'package:flutter/material.dart';
import 'package:robotic_hand/external/send_commands_to_denso.dart';
import 'package:robotic_hand/external/send_commands_to_robotic_hand.dart';
import 'package:robotic_hand/external/server_status.dart';

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
  bool isServerActive = false;

  Map<String, bool> buttonStates = {
    'Garrafa': true,
    'Telefone': true,
    'Pote': true,
    'Medicamento': true,
    'Mover Robô': false,
    'Finalizar': false,
  };

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
              onPressed: buttonStates['Mover Robô']!?() async {
                String msg = await sendCommandMoveToDenso();
                popup(msg);
                setState(() {
                  buttonStates['Mover Robô'] = false;
                  buttonStates['Finalizar'] = true;
                });
              } : null,
              child: const Text('Mover Robô'),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Controle de abertura da mão: '),
                Slider(
                  value: porcentagem,
                  min: 0,
                  max: 180,
                  onChanged: (value) {
                    setState(() {
                      porcentagem = value;
                      String porcentagemSend = porcentagem.toString();
                      sendCommandToRoboticHand(porcentagemSend);
                    });
                  },
                ),
                Text('${porcentagem.toInt()}°',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: buttonStates['Finalizar']!?() async {
                String msg = await finalizeMoveDenso();
                popup(msg);
                setState(() {
                  buttonStates['Finalizar'] = false;
                });
              } : null,
              child: const Text('Finalizar'),
            ),
            const SizedBox(height: 20.0),
            Text('Status do servidor: ${isServerActive ? 'Ativo' : 'Inativo'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: isServerActive ? Colors.green : Colors.red,
            ),
            ),
            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: () async {
                bool serverIsActive = await serverStatus();
                setState(() {
                  isServerActive = serverIsActive;
                });
              },
              child: const Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonWithImage(BuildContext context, String buttonText, String imagePath) {
    Color buttonColor;
    int move;
    if(buttonText == 'Garrafa'){
      move = 0;
      buttonColor = const Color(0xFF65b3fc);
    } else if(buttonText == 'Telefone'){
      move = 1;
      buttonColor = const Color(0xFF838e98);
    } else if(buttonText == 'Pote'){
      move = 2;
      buttonColor = const Color(0xFF9ae094);
    } else {
      move = 3;
      buttonColor = const Color(0xFFbbbdbe);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: buttonStates[buttonText]!? () async {
            String msg = await sendCommandToDenso(move);
            popup(msg);      
            if(msg == 'Erro ao enviar as posições para o Denso'){

            } else {
            setState(() {
              buttonStates[buttonText] = false;
              buttonStates['Mover Robô'] = true;
            });
            }
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
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

  void popup(String titulo) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(titulo),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
