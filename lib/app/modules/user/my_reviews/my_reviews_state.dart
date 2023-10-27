part of 'my_reviews_cubit.dart';

class MyReviewsState extends Equatable {
  const MyReviewsState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus = ApiResponseStatus.none,
    this.handymanReviews,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus apiResponseStatus;
  final List<HandymanReviewData>? handymanReviews;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        handymanReviews,
      ];

  MyReviewsState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    List<HandymanReviewData>? handymanReviews,
  }) {
    return MyReviewsState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      handymanReviews: handymanReviews ?? this.handymanReviews,
    );
  }
}
