import 'package:flutter_chat_core/flutter_chat_core.dart';

class PerguntaLista {
  final TextMessage mensagem;
  bool enviada;

  PerguntaLista({required this.mensagem, this.enviada = false});
}