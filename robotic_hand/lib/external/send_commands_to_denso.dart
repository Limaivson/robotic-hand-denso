// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = 'http://127.0.0.1:8000/';

Future<String> sendCommandToDenso(int move) async {
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
  
  try {
    var response = await http.post(
      uri, 
      body: {'positions': positions}
    );
    Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseData['message'];
    } else {
      return responseData['message'];
    }
  } catch (e) {
    return 'Erro ao enviar as posições para o Denso';
  }
}  

 Future<String> sendCommandMoveToDenso() async {
  var uri = Uri.parse('$url/move-denso/');
  try {
    var response = await http.post(uri);
    Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseData['message'];
    } else {
      return responseData['message'];
    }
  } catch (e) {
    return 'Erro ao enviar o comando para o Denso';
  }
}

Future<String> finalizeMoveDenso() async {
  var uri = Uri.parse('$url/finalize-denso/');
  try {
    var response = await http.post(uri);
    Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return responseData['message'];
    } else {
      return responseData['message'];
    }
  } catch (e) {
    return 'Erro ao enviar o comando para o Denso';
  }
}

