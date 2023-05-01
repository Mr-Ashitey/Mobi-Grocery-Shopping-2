import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GroceryListItemEntity {
  final int id;
  final String name;
  final bool isCollected;

  GroceryListItemEntity(
      {required this.id, required this.name, this.isCollected = false});
}
