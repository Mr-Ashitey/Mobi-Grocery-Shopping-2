// Mocks generated by Mockito 5.4.0 from annotations
// in mobi_grocery_shopping_2/test/feature/grocery_list/domain/usecases/grocery_list_usecases/add_grocery_list_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mobi_grocery_shopping_2/core/error/failure.dart' as _i5;
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/entities/grocery_list_entity.dart'
    as _i6;
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/repositories/grocery_list_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GroceryListRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGroceryListRepository extends _i1.Mock
    implements _i3.GroceryListRepository {
  MockGroceryListRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.GroceryListEntity>>>
      getGroceryLists() => (super.noSuchMethod(
            Invocation.method(
              #getGroceryLists,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure, List<_i6.GroceryListEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.GroceryListEntity>>(
              this,
              Invocation.method(
                #getGroceryLists,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.Either<_i5.Failure, List<_i6.GroceryListEntity>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.GroceryListEntity>> getGroceryList(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getGroceryList,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.GroceryListEntity>>.value(
                _FakeEither_0<_i5.Failure, _i6.GroceryListEntity>(
          this,
          Invocation.method(
            #getGroceryList,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.GroceryListEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> addGroceryList(
          _i6.GroceryListEntity? groceryList) =>
      (super.noSuchMethod(
        Invocation.method(
          #addGroceryList,
          [groceryList],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #addGroceryList,
            [groceryList],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> updateGroceryList(
          _i6.GroceryListEntity? groceryList) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateGroceryList,
          [groceryList],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #updateGroceryList,
            [groceryList],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteGroceryList(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteGroceryList,
          [id],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #deleteGroceryList,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}