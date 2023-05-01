import '../../domain/entities/grocery_list_item_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'grocery_list_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroceryListItemModel extends GroceryListItemEntity {
  @JsonKey(fromJson: _fromJsonId, name: "id")
  final int groceryListItemId;

  @JsonKey(name: "name")
  final String groceryListItemName;

  @JsonKey(name: "isCollected")
  final bool groceryListItemIsCollected;

  const GroceryListItemModel({
    required this.groceryListItemId,
    required this.groceryListItemName,
    this.groceryListItemIsCollected = false,
  }) : super(
            id: groceryListItemId,
            name: groceryListItemName,
            isCollected: groceryListItemIsCollected);

  factory GroceryListItemModel.fromJson(Map<String, dynamic> json) =>
      _$GroceryListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListItemModelToJson(this);

  static int _fromJsonId(dynamic id) {
    if (id is int) {
      return id;
    }
    return int.parse(id);
  }
}
