import 'package:payflow/shared/enums/TypeAccounts.dart';

class TypeAccountsKeys {
  final strings = [
    "Carteira",
    "Conta Corrente",
    "Reserva",
    "Cartao Crédito",
    "Carteira Eletronica",
  ];

  String getString(TypeAccount type) => strings[type.index];
}
