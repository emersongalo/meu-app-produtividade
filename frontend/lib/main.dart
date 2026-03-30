import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(home: HabitosApp()));

class HabitosApp extends StatefulWidget {
  @override
  _HabitosAppState createState() => _HabitosAppState();
}

class _HabitosAppState extends State<HabitosApp> {
  List itens = [];

  // Função que busca os dados na sua API da Vercel
  Future<void> buscarDados() async {
    final url = 'https://meu-app-produtividade.vercel.app/'; // <--- COLOQUE SEU LINK AQUI
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          itens = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Erro ao conectar: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    buscarDados(); // Busca os dados assim que o app abre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Hábitos e Tarefas')),
      body: itens.isEmpty 
          ? Center(child: CircularProgressIndicator()) // Carregando...
          : ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(itens[index]['tipo'] == 'habito' ? Icons.repeat : Icons.check_box),
                  title: Text(itens[index]['titulo']),
                  subtitle: Text("Tipo: ${itens[index]['tipo']}"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: buscarDados, // Botão para atualizar a lista
        child: Icon(Icons.refresh),
      ),
    );
  }
}