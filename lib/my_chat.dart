import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive/hive.dart';
import 'package:pdi_generator/pdi.dart';
import 'package:pdi_generator/pergunta_lista.dart';
import 'package:uuid/uuid.dart';

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  MyChatState createState() => MyChatState();
}

class MyChatState extends State<MyChat> {
  final _chatController = InMemoryChatController();
  final _botUser = 'bot';
  final _humanUser = 'user1';
  late List<TextMessage> _perguntas = [];
  List<String> _respostas = [];
  int _contadorPerguntas = 0;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Bem vindo ao gerador de PDI. Qual é o seu nome, cargo atual, há quanto tempo está nessa função e qual sua formação acadêmica?'
      ),
    );
    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Qual o prazo que você imagina para este plano de desenvolvimento? Quais passos acredita que precisa dar para chegar lá?'
      ),
    );
    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Quais são seus principais pontos fortes e quais aspectos você acredita que precisa melhorar?'
      ),
    );
    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Quais competências técnicas ou comportamentais você considera fundamentais para atingir seus objetivos e ainda precisa desenvolver?'
      ),
    );
    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Que tipos de ações você está disposto(a) a realizar para se desenvolver (ex: cursos, projetos, mentorias) e qual formato funciona melhor para você?'
      ),
    );
    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Quanto tempo por semana você pode dedicar ao seu desenvolvimento profissional e que recursos você tem à disposição?'
      ),
    );
    _perguntas.add(TextMessage(
      id: Uuid().v4(),
      authorId: _botUser,
      createdAt: DateTime.now().toUtc(),
      text: 'Quem pode te apoiar nesse plano de desenvolvimento e com que frequência você gostaria de revisar seu progresso?'
      ),
    );
    _chatController.insertMessage(_perguntas.first);
  }

  String _gerarPrompt() {
    final buffer = StringBuffer();

    for(int i = 0; i < _respostas.length; i++) {
      buffer.writeln('Pergunta: ${_perguntas[i].text}');
      buffer.writeln('Resposta: ${_respostas[i]}');
    }
    buffer.writeln('Com base nas respostas acima, gere um Plano de Desenvolvimento Individual (PDI) completo e personalizado, '
        'considerando metas, ações e prazos realistas. O PDI deve ser claro, objetivo e formatado em tópicos. '
        'Se possível, sugira links com material de apoio ou cursos.');

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Chat(
          theme: ChatTheme.fromThemeData(Theme.of(context)),
          chatController: _chatController,
          currentUserId: _humanUser,
          onMessageSend: (text) {
            _chatController.insertMessage(
              TextMessage(
                id: Uuid().v4(),
                authorId: _humanUser,
                createdAt: DateTime.now().toUtc(),
                text: text,
              ),
            );
            _respostas.add(text);

            if (_respostas.length < _perguntas.length) {
              _chatController.insertMessage(_perguntas[_respostas.length]);
            } else {
              _chatController.insertMessage(TextMessage(
                id: Uuid().v4(),
                authorId: _botUser,
                createdAt: DateTime.now().toUtc(),
                text: 'Obrigado pelas respostas, seu plano de desenvolvimento será gerado agora.'
              ));
              final prompt = _gerarPrompt();

              Gemini.instance.prompt(parts: [
                Part.text(prompt),
              ]).then((value) async {
                final output = value?.output ?? '';
                if (output.isNotEmpty) {
                  _chatController.insertMessage(
                    TextMessage(
                      id: Uuid().v4(),
                      authorId: _botUser,
                      text: output
                    )
                  );
                  final pdi = Pdi(
                    id: Uuid().v4(),
                    prompt: prompt,
                    resposta: output,
                    criadoEm: DateTime.now(),
                  );

                  final box = Hive.box<Pdi>('pdis');
                  await box.add(pdi);
                }
              }).catchError((e) {
                _chatController.insertMessage(
                  TextMessage(
                    id: Uuid().v4(),
                    authorId: _botUser,
                    text: 'Houve um erro na geração do PDI. Tente novamente mais tarde.'
                  )
                );
              });
            }
          },
          resolveUser: (UserID id) async {
            return User(id: id, name: _humanUser);
          },
        ),
      ),
    );
  }
}