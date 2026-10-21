// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FoodViewModel)
const foodViewModelProvider = FoodViewModelProvider._();

final class FoodViewModelProvider
    extends $NotifierProvider<FoodViewModel, FoodFilter> {
  const FoodViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodViewModelHash();

  @$internal
  @override
  FoodViewModel create() => FoodViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodFilter>(value),
    );
  }
}

String _$foodViewModelHash() => r'b74ea4f4428507ce4e918a92f44ae1d169b20ca6';

abstract class _$FoodViewModel extends $Notifier<FoodFilter> {
  FoodFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FoodFilter, FoodFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FoodFilter, FoodFilter>,
              FoodFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Danh sách Category (hiển thị ngang ở Home).

@ProviderFor(categories)
const categoriesProvider = CategoriesProvider._();

/// Danh sách Category (hiển thị ngang ở Home).

final class CategoriesProvider
    extends $FunctionalProvider<List<Category>, List<Category>, List<Category>>
    with $Provider<List<Category>> {
  /// Danh sách Category (hiển thị ngang ở Home).
  const CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $ProviderElement<List<Category>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Category> create(Ref ref) {
    return categories(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Category> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Category>>(value),
    );
  }
}

String _$categoriesHash() => r'b95e4dd2cacf37ee57b2402e10cc9d2963f5b453';

/// Category đang chọn (null nếu là All).

@ProviderFor(selectedCategory)
const selectedCategoryProvider = SelectedCategoryProvider._();

/// Category đang chọn (null nếu là All).

final class SelectedCategoryProvider
    extends $FunctionalProvider<Category?, Category?, Category?>
    with $Provider<Category?> {
  /// Category đang chọn (null nếu là All).
  const SelectedCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryHash();

  @$internal
  @override
  $ProviderElement<Category?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Category? create(Ref ref) {
    return selectedCategory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Category? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Category?>(value),
    );
  }
}

String _$selectedCategoryHash() => r'281f73d253f1f3ebc960157405c97e80e9d838a8';

/// Popular Foods: rating >= 4.5.

@ProviderFor(popularFoods)
const popularFoodsProvider = PopularFoodsProvider._();

/// Popular Foods: rating >= 4.5.

final class PopularFoodsProvider
    extends $FunctionalProvider<List<Food>, List<Food>, List<Food>>
    with $Provider<List<Food>> {
  /// Popular Foods: rating >= 4.5.
  const PopularFoodsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularFoodsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularFoodsHash();

  @$internal
  @override
  $ProviderElement<List<Food>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Food> create(Ref ref) {
    return popularFoods(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Food> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Food>>(value),
    );
  }
}

String _$popularFoodsHash() => r'2413657a8db568cdf348b237a6f199c515fd256c';

/// Food hiển thị ở Foods Page theo Category + từ khóa.

@ProviderFor(filteredFoods)
const filteredFoodsProvider = FilteredFoodsProvider._();

/// Food hiển thị ở Foods Page theo Category + từ khóa.

final class FilteredFoodsProvider
    extends $FunctionalProvider<List<Food>, List<Food>, List<Food>>
    with $Provider<List<Food>> {
  /// Food hiển thị ở Foods Page theo Category + từ khóa.
  const FilteredFoodsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredFoodsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredFoodsHash();

  @$internal
  @override
  $ProviderElement<List<Food>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Food> create(Ref ref) {
    return filteredFoods(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Food> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Food>>(value),
    );
  }
}

String _$filteredFoodsHash() => r'6c292b5f0698f26439c75febd307b4cef32d7f86';

/// Tab đang chọn của BottomNavigationBar: 0 Home, 1 Foods, 2 Favorite, 3 Profile.

@ProviderFor(MainNav)
const mainNavProvider = MainNavProvider._();

/// Tab đang chọn của BottomNavigationBar: 0 Home, 1 Foods, 2 Favorite, 3 Profile.
final class MainNavProvider extends $NotifierProvider<MainNav, int> {
  /// Tab đang chọn của BottomNavigationBar: 0 Home, 1 Foods, 2 Favorite, 3 Profile.
  const MainNavProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainNavProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainNavHash();

  @$internal
  @override
  MainNav create() => MainNav();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mainNavHash() => r'11a393941972d105865aa4eeb275a68942346750';

/// Tab đang chọn của BottomNavigationBar: 0 Home, 1 Foods, 2 Favorite, 3 Profile.

abstract class _$MainNav extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
