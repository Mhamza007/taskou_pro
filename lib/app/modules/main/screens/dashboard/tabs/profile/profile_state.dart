part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.profileImage,
    this.countryCode,
    this.flag,
    this.hint,
    this.maxLength,
    this.exampleNumber,
    this.userName = 'User Name',
    this.phoneNumber = '+1 XXX-XXX-XXX',
    this.address = 'San Franci California',
    this.description = 'Pro',
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final String? profileImage;
  final String? countryCode;
  final String? flag;
  final String? hint;
  final int? maxLength;
  final String? exampleNumber;
  final String? userName;
  final String? phoneNumber;
  final String? address;
  final String? description;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        profileImage,
        countryCode,
        flag,
        hint,
        maxLength,
        userName,
        phoneNumber,
        address,
        description,
      ];

  ProfileState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    String? profileImage,
    String? countryCode,
    String? flag,
    String? hint,
    int? maxLength,
    String? exampleNumber,
    String? userName,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      profileImage: profileImage ?? this.profileImage,
      countryCode: countryCode ?? this.countryCode,
      flag: flag ?? this.flag,
      hint: hint ?? this.hint,
      maxLength: maxLength ?? this.maxLength,
      exampleNumber: exampleNumber ?? this.exampleNumber,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }
}
