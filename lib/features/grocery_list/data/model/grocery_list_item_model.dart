import '../../domain/entities/grocery_list_item_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'grocery_list_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroceryListItemModel extends GroceryListItemEntity {
  @JsonKey(fromJson: _fromJsonId)
  int groceryListItemId;
  String groceryListItemName;
  bool groceryListItemIsCollected;

  GroceryListItemModel({
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
    return (id as num).toInt();
  }
}
