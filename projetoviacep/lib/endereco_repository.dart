import 'package:dio/dio.dart';
import 'package:projetoviacep/endereco_modelo.dart';
import 'dart:developer';

class EnderecoRepository {
  final dio = Dio(BaseOptions(baseUrl: "https://viacep.com.br/ws/"));

  Future<EnderecoModelo> getEndereco({
    required String cep,
  }) async {
    try {
      final response = await dio.get("$cep/json");

      log(response.realUri.toString());

      log(response.data.toString());
      if (response.data['erro'] != null && response.data['erro'] == true) {
        throw "CEP não encontrado";
      }

      final endereco = EnderecoModelo.fromMap(response.data);

      return endereco;
    } catch (e) {
      rethrow;
    }
  }
}
