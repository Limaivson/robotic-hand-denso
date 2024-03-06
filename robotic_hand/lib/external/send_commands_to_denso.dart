// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

String url = 'http://127.0.0.1:8000/';

void sendCommandToDenso(int move) async {
  var uri = Uri.parse('$url/control-denso/');

  String positions;

  if(move==0){
    positions = '023, 355, 645, 555, 973';
  } else if(move==1){
    positions = '123, 355, 645, 555, 973';
  } else if(move==2){
    positions = '223, 355, 645, 555, 973';
  } else {
    positions = '323, 355, 645, 555, 973';
  }
  debugPrint(positions);
  try {
    var response = await http.post(
      uri, 
      body: {'positions': positions}
    );
    if (response.statusCode == 200) {
      debugPrint('Comando enviado com sucesso');
    } else {
      debugPrint('Falha ao enviar as posições para o Denso. Código de erro: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Erro: $e');
  }
}  

void sendCommandMoveToDenso() async {
  var uri = Uri.parse('$url/move-denso/');

  try {
    var response = await http.post(uri);
    if (response.statusCode == 200) {
      debugPrint('Comando enviado com sucesso');
    } else {
      Map<String, dynamic> responseData = json.decode(response.body);
      debugPrint('Error: ${responseData['message']}');
    }
  } catch (e) {
    debugPrint('Erro: $e');
  }
}
