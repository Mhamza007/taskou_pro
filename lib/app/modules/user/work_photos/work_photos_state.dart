part of 'work_photos_cubit.dart';

class WorkPhotosState extends Equatable {
  const WorkPhotosState({
    this.loading = false,
    this.photos,
    this.video,
    this.videoThumbnail,
    this.message = '',
    this.apiResponseStatus,
  });

  final bool loading;
  final List<Map<String, dynamic>>? photos;
  final String? video;
  final String? videoThumbnail;
  final String message;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        loading,
        photos,
        video,
        videoThumbnail,
        message,
        apiResponseStatus,
      ];

  WorkPhotosState copyWith({
    bool? loading,
    List<Map<String, dynamic>>? photos,
    String? video,
    String? videoThumbnail,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return WorkPhotosState(
      loading: loading ?? this.loading,
      photos: photos ?? this.photos,
      video: video ?? this.video,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
