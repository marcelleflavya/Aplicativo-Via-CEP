import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projetoviacep/endereco_modelo.dart';
import 'package:projetoviacep/endereco_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cepController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  EnderecoModelo? endereco;

  String? erro;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Aplicativo Via CEP'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                    controller: cepController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [cepMask],
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 9) {
                        return "Cep inválido, tente novamente";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "CEP",
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  endereco = null;
                  erro = null;
                });
                if (formKey.currentState!.validate()) {
                  final enderecoRepository = EnderecoRepository();

                  try {
                    endereco = await enderecoRepository.getEndereco(
                      cep: cepController.text,
                    );
                    setState(() {});
                  } catch (e) {
                    erro = e.toString();

                    setState(() {});
                  }
                }
              },
              child: const Text("Buscar CEP"),
            ),
            if (endereco != null) Text(endereco.toString()),
            if (erro != null) Text(erro.toString()),
          ],
        ),
      ),
    );
  }
}
