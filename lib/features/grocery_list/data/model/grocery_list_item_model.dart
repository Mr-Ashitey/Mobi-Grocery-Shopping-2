import '../../domain/entities/grocery_list_item_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'grocery_list_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroceryListItemModel extends GroceryListItemEntity {
  GroceryListItemModel({
    required int id,
    required String name,
    bool isCollected = false,
  }) : super(id: id, name: name, isCollected: isCollected);

  factory GroceryListItemModel.fromJson(Map<String, dynamic> json) =>
      _$GroceryListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListItemModelToJson(this);
}
