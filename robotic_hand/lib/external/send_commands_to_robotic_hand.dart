// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void sendCommandToRoboticHand(String positions) async {
  String url = 'http://127.0.0.1:8000/';
  var uri = Uri.parse('$url/control-hand/');
  try{
    var response = await http.post(
      uri,
      body: {'move_hand': positions}
    );
    if(response.statusCode == 200){
      debugPrint('Comando enviado com sucesso');
    } else {
      debugPrint('Falha ao enviar as posições para a mão robótica. Código de erro: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Erro: $e');
  }
}
