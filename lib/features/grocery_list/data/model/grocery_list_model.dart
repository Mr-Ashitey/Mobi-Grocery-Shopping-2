import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/grocery_list_entity.dart';
import 'grocery_list_item_model.dart';

part 'grocery_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroceryListModel extends GroceryListEntity {
  @JsonKey(fromJson: _fromJsonId, name: "id", includeToJson: false)
  final int? groceryListId;

  @JsonKey(name: "name")
  final String groceryListName;

  @JsonKey(name: "grocery_list_item", includeToJson: false)
  final List<GroceryListItemModel> groceryListItemsModel;

  const GroceryListModel({
    this.groceryListId,
    required this.groceryListName,
    this.groceryListItemsModel = const <GroceryListItemModel>[],
  }) : super(
            id: groceryListId ?? 0,
            name: groceryListName,
            groceryListItems: groceryListItemsModel);

  factory GroceryListModel.fromJson(Map<String, dynamic> json) =>
      _$GroceryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListModelToJson(this);

  static int _fromJsonId(dynamic id) {
    if (id is int) {
      return id;
    }
    return int.parse(id);
  }
}
