import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/grocery_list_entity.dart';
import 'grocery_list_item_model.dart';

part 'grocery_list_model.g.dart';

@JsonSerializable()
class GroceryListModel extends GroceryListEntity {
  GroceryListModel({
    required int id,
    required String name,
    List<GroceryListItemModel> groceryListItems =
        const <GroceryListItemModel>[],
  }) : super(id: id, name: name, groceryListItems: groceryListItems);

  factory GroceryListModel.fromJson(Map<String, dynamic> json) =>
      _$GroceryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListModelToJson(this);
}
