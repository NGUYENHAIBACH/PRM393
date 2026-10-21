// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nguồn dữ liệu Food (in-memory). State là danh sách Food hiện tại,
/// khi đổi favorite thì state đổi và mọi nơi đang watch sẽ tự cập nhật.

@ProviderFor(FoodRepository)
const foodRepositoryProvider = FoodRepositoryProvider._();

/// Nguồn dữ liệu Food (in-memory). State là danh sách Food hiện tại,
/// khi đổi favorite thì state đổi và mọi nơi đang watch sẽ tự cập nhật.
final class FoodRepositoryProvider
    extends $NotifierProvider<FoodRepository, List<Food>> {
  /// Nguồn dữ liệu Food (in-memory). State là danh sách Food hiện tại,
  /// khi đổi favorite thì state đổi và mọi nơi đang watch sẽ tự cập nhật.
  const FoodRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodRepositoryHash();

  @$internal
  @override
  FoodRepository create() => FoodRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Food> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Food>>(value),
    );
  }
}

String _$foodRepositoryHash() => r'cc710c4464890f8d7884abde049c2151e25889f6';

/// Nguồn dữ liệu Food (in-memory). State là danh sách Food hiện tại,
/// khi đổi favorite thì state đổi và mọi nơi đang watch sẽ tự cập nhật.

abstract class _$FoodRepository extends $Notifier<List<Food>> {
  List<Food> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Food>, List<Food>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Food>, List<Food>>,
              List<Food>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
