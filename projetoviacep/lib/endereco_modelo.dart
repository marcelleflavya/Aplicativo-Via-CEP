import 'dart:convert';

class EnderecoModelo {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  EnderecoModelo({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
    };
  }

  factory EnderecoModelo.fromMap(Map<String, dynamic> map) {
    return EnderecoModelo(
      cep: map['cep'] ?? '',
      logradouro: map['logradouro']  ?? '',
      complemento: map['complemento']  ?? '',
      bairro: map['bairro']  ?? '',
      localidade: map['localidade']  ?? '',
      uf: map['uf'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModelo.fromJson(String source) => EnderecoModelo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "$logradouro, $complemento\n$bairro, $localidade - $uf\n$cep";
  }
}
