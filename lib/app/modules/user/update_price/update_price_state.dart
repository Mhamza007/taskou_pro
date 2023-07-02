part of 'update_price_cubit.dart';

class UpdatePriceState extends Equatable {
  const UpdatePriceState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
      ];

  UpdatePriceState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return UpdatePriceState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
