import 'package:flutter/material.dart';
import 'anuncio.dart';
import 'cadastro.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Anuncio> _list = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anúncios", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, position) {
          Anuncio item = _list[position];
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.green,
              child: const Align(
                alignment: Alignment(-0.9, 0.0),
                child: Icon(Icons.edit, color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment(0.9, 0.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                Anuncio? editedAnuncio = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cadastro(anuncio: item),
                  ),
                );

                if (editedAnuncio != null) {
                  setState(() {
                    _list.removeAt(position);
                    _list.insert(position, editedAnuncio);
                  });
                }
                return false;
              } else if (direction == DismissDirection.endToStart) {
                return true;
              }
              return false;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  _list.removeAt(position);
                });
              }
            },
            child: ListTile(
              leading: Icon(Icons.image, size: 50, color: Colors.grey),
              title: Text(item.titulo, style: TextStyle(fontSize: 16)),
              subtitle: Text(item.descricao),
              trailing: Text(
                "R\$ ${item.preco.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onLongPress: () async {
                Anuncio? editedAnuncio = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cadastro(anuncio: item),
                  ),
                );

                if (editedAnuncio != null) {
                  setState(() {
                    _list.removeAt(position);
                    _list.insert(position, editedAnuncio);
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          try {
            Anuncio newAnuncio = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cadastro()),
            );
            setState(() {
              _list.add(newAnuncio);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
      ),
    );
  }
}
