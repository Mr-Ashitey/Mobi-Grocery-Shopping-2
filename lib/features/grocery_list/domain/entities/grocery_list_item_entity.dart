import 'package:equatable/equatable.dart';

class GroceryListItemEntity extends Equatable {
  final int id;
  final String name;
  final bool isCollected;

  const GroceryListItemEntity(
      {required this.id, required this.name, this.isCollected = false});

  @override
  List<Object?> get props => [id, name, isCollected];
}
