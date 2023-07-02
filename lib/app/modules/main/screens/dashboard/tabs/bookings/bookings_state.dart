part of 'bookings_cubit.dart';

class BookingsState extends Equatable {
  const BookingsState({
    this.currentLoading = true,
    this.pastLoading = true,
    this.upcomingLoading = true,
    this.message = '',
    this.apiResponseStatus,
    this.newBookingsResponseList,
    this.runningBookingsResponseList,
    this.pastBookingsResponseList,
  });

  final bool currentLoading;
  final bool pastLoading;
  final bool upcomingLoading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final List<GetBookingsData>? newBookingsResponseList;
  final List<GetBookingsData>? runningBookingsResponseList;
  final List<GetBookingsData>? pastBookingsResponseList;

  @override
  List<Object?> get props => [
        currentLoading,
        pastLoading,
        upcomingLoading,
        message,
        apiResponseStatus,
        newBookingsResponseList,
        runningBookingsResponseList,
        pastBookingsResponseList,
      ];

  BookingsState copyWith({
    bool? currentLoading,
    bool? pastLoading,
    bool? upcomingLoading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    List<GetBookingsData>? newBookingsResponseList,
    List<GetBookingsData>? runningBookingsResponseList,
    List<GetBookingsData>? pastBookingsResponseList,
  }) {
    return BookingsState(
      currentLoading: currentLoading ?? this.currentLoading,
      pastLoading: pastLoading ?? this.pastLoading,
      upcomingLoading: upcomingLoading ?? this.upcomingLoading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      newBookingsResponseList:
          newBookingsResponseList ?? this.newBookingsResponseList,
      runningBookingsResponseList:
          runningBookingsResponseList ?? this.runningBookingsResponseList,
      pastBookingsResponseList:
          pastBookingsResponseList ?? this.pastBookingsResponseList,
    );
  }
}
