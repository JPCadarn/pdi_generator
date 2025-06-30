import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pdi_generator/pdi.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late Box<Pdi> _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box<Pdi>('pdis');
  }

  @override
  Widget build(BuildContext context) {
    final pdis = _box.values.toList().reversed.toList();

    return Scaffold(
      body: pdis.isEmpty
          ? const Center(child: Text('Nenhum PDI salvo ainda.'))
          : ListView.builder(
        itemCount: pdis.length,
        itemBuilder: (context, index) {
          final pdi = pdis[index];
          final data = DateFormat('dd/MM/yyyy – HH:mm').format(pdi.criadoEm);

          return Dismissible(
            key: Key(pdi.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (_) {
              pdi.delete();
              setState(() {});
            },
            child: ListTile(
              title: Text('PDI de $data'),
              subtitle: Text(pdi.prompt.split('\n').first, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetalhePdiPage(pdi: pdi)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetalhePdiPage extends StatelessWidget {
  final Pdi pdi;

  const DetalhePdiPage({super.key, required this.pdi});

  @override
  Widget build(BuildContext context) {
    final data = DateFormat('dd/MM/yyyy – HH:mm').format(pdi.criadoEm);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do PDI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Criado em: $data', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Perguntas e Respostas:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(pdi.prompt),
            const SizedBox(height: 24),
            const Text('Plano Gerado:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(pdi.resposta),
          ],
        ),
      ),
    );
  }
}
