import 'dart:convert';
import 'package:http/http.dart' as http;


var url = 'https://economia.awesomeapi.com.br';

getAllCotacao() async {
  var parse = Uri.parse('$url/all'),
    response = await http.get(parse);

  return jsonDecode(response.body);
}

getByMoeda(moedas) async {
  var parse = Uri.parse('$url/json/all/$moedas'), 
    response = await http.get(parse);

  return jsonDecode(response.body);
}
