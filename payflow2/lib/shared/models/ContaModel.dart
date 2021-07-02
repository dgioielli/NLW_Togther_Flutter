import 'dart:convert';

import 'package:payflow/shared/enums/TypeAccounts.dart';

class ContaModel {
  final String? id;
  final String? name;
  final int? type;
  final double? currentValue;

  TypeAccount get typeEnum =>
      type != null ? TypeAccount.values[type!] : TypeAccount.carteira;

  ContaModel({
    this.id,
    this.name,
    this.type,
    this.currentValue,
  });

  ContaModel copyWith({
    String? id,
    String? name,
    int? type,
    double? currentValue,
  }) {
    return ContaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      currentValue: currentValue ?? this.currentValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'currentValue': currentValue,
    };
  }

  factory ContaModel.fromMap(Map<String, dynamic> map) {
    return ContaModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      currentValue: map['currentValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContaModel.fromJson(String source) =>
      ContaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContaModel(id: $id, name: $name, type: $type, currentValue: $currentValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContaModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.currentValue == currentValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ type.hashCode ^ currentValue.hashCode;
  }
}
