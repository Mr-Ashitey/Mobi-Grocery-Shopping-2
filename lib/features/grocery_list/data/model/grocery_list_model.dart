import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/grocery_list_entity.dart';
import 'grocery_list_item_model.dart';

part 'grocery_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroceryListModel extends GroceryListEntity {
  @JsonKey(fromJson: _fromJsonId)
  int groceryListId;
  String groceryListName;
  List<GroceryListItemModel> groceryListItemsModel;

  GroceryListModel({
    required this.groceryListId,
    required this.groceryListName,
    this.groceryListItemsModel = const <GroceryListItemModel>[],
  }) : super(
            id: groceryListId,
            name: groceryListName,
            groceryListItems: groceryListItemsModel);

  factory GroceryListModel.fromJson(Map<String, dynamic> json) =>
      _$GroceryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryListModelToJson(this);

  static int _fromJsonId(dynamic id) {
    return (id as num).toInt();
  }
}
