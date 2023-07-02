part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.profileImage,
    this.profileImagePath,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final String? profileImage;
  final String? profileImagePath;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        profileImage,
        profileImagePath,
      ];

  UpdateProfileState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    String? profileImage,
    String? profileImagePath,
  }) {
    return UpdateProfileState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      profileImage: profileImage ?? this.profileImage,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
