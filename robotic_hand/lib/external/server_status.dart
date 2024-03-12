import 'package:flutter/material.dart';
import 'package:robotic_hand/external/url.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

Future serverStatus() async {
  var uri = Uri.parse('$url/server-status/');
  try{
    var response = await http.get(uri);
    if(response.statusCode == 200){
      debugPrint('Servidor está ativo');
      return true;
    } else {
      debugPrint('Falha ao verificar o status do servidor. Código de erro: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    debugPrint('Erro: $e');
    return false;
  }
}

