part of 'kart_cubit.dart';

@immutable
sealed class KartState {}

final class KartInitial extends KartState {}

final class KartLoading extends KartState {}

final class KartSuccess extends KartState {
  final List<ProductModel> cartItems;
  KartSuccess(this.cartItems);
}

final class KartSuccessWithLenth extends KartState {
  final List<ProductModel> cartItems;
  KartSuccessWithLenth(this.cartItems);
}

final class KartFail extends KartState {
  String error;

  KartFail(this.error);
}
