import 'package:flutter/material.dart';
import 'anuncio.dart';

class Cadastro extends StatefulWidget {
  final Anuncio? anuncio;

  const Cadastro({super.key, this.anuncio});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.anuncio != null) {
      setState(() {
        _tituloController.text = widget.anuncio!.titulo;
        _descricaoController.text = widget.anuncio!.descricao;
        _precoController.text = widget.anuncio!.preco.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          widget.anuncio == null ? "Cadastro de Anúncio" : "Editar Anúncio",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _tituloController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: "Título",
                  labelStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preenchimento Obrigatório";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _descricaoController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: "Descrição",
                  labelStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preenchimento Obrigatório";
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: "Preço",
                  labelStyle: TextStyle(fontSize: 18),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Preenchimento Obrigatório";
                  }
                  if (double.tryParse(value.replaceAll(",", ".")) == null) {
                    return "Preço inválido";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          Anuncio newAnuncio = Anuncio(
                            _tituloController.text,
                            _descricaoController.text,
                            double.parse(
                              _precoController.text.replaceAll(",", "."),
                            ),
                          );
                          Navigator.pop(context, newAnuncio);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        //Retorna para tela anterior
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
