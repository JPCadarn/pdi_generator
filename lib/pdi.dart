import 'package:hive/hive.dart';

part 'pdi.g.dart';

@HiveType(typeId: 0)
class Pdi extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String prompt;

  @HiveField(2)
  String resposta;

  @HiveField(3)
  DateTime criadoEm;

  Pdi({
    required this.id,
    required this.prompt,
    required this.resposta,
    required this.criadoEm,
  });
}