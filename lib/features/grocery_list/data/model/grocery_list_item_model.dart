import '../../domain/entities/grocery_list_item_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'grocery_list_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroceryListItemModel extends GroceryListItemEntity {
  @JsonKey(fromJson: _fromJsonId, name: "id", includeToJson: false)
  final int? groceryListItemId;

  @JsonKey(name: "name")
  final String groceryListItemName;

  @JsonKey(name: "collected")
  final bool groceryListItemIsCollected;

  @JsonKey(name: "grocery_list_id")
  final int? groceryListId;

  const GroceryListItemModel({
    this.groceryListItemId,
    required this.groceryListItemName,
    this.groceryListItemIsCollected = false,
    this.groceryListId,
  }) : super(
            id: groceryListItemId ?? 0,
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
