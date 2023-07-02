part of 'complete_profile_cubit.dart';

class CompleteProfileState extends Equatable {
  const CompleteProfileState({
    this.profileImage,
    this.userName,
    this.loading = false,
    this.photoLoading = false,
    this.professionsCompleted = false,
    this.workPhotosCompleted = false,
    this.documentsCompleted = false,
  });

  final File? profileImage;
  final String? userName;
  final bool loading;
  final bool photoLoading;
  final bool professionsCompleted;
  final bool workPhotosCompleted;
  final bool documentsCompleted;

  @override
  List<Object?> get props => [
        profileImage,
        userName,
        loading,
        photoLoading,
        professionsCompleted,
        workPhotosCompleted,
        documentsCompleted,
      ];

  CompleteProfileState copyWith({
    File? profileImage,
    String? userName,
    bool? loading,
    bool? photoLoading,
    bool? professionsCompleted,
    bool? workPhotosCompleted,
    bool? documentsCompleted,
  }) {
    return CompleteProfileState(
      profileImage: profileImage ?? this.profileImage,
      userName: userName ?? this.userName,
      loading: loading ?? this.loading,
      photoLoading: photoLoading ?? this.photoLoading,
      professionsCompleted: professionsCompleted ?? this.professionsCompleted,
      workPhotosCompleted: workPhotosCompleted ?? this.workPhotosCompleted,
      documentsCompleted: documentsCompleted ?? this.documentsCompleted,
    );
  }
}
