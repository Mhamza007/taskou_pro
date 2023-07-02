part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.loading = false,
    this.message = '',
    this.apiResponseStatus,
    this.themeMode,
    this.selectedIndex = 0,
    this.onDuty = false,
    this.editMode = false,
    this.currentPageTitle = '',
    this.userName = 'User Name',
    this.phoneNumber = '+1234567890',
    this.imageUrl,
  });

  final bool loading;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final ThemeMode? themeMode;
  final int selectedIndex;
  final bool onDuty;
  final bool editMode;
  final String currentPageTitle;
  final String userName;
  final String phoneNumber;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        loading,
        message,
        apiResponseStatus,
        themeMode,
        selectedIndex,
        onDuty,
        editMode,
        currentPageTitle,
        userName,
        phoneNumber,
        imageUrl,
      ];

  DashboardState copyWith({
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    ThemeMode? themeMode,
    int? selectedIndex,
    bool? editMode,
    bool? onDuty,
    String? currentPageTitle,
    String? userName,
    String? phoneNumber,
    String? imageUrl,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      themeMode: themeMode ?? this.themeMode,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      onDuty: onDuty ?? this.onDuty,
      editMode: editMode ?? this.editMode,
      currentPageTitle: currentPageTitle ?? this.currentPageTitle,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'DashboardState(themeMode: $themeMode, selectedIndex: $selectedIndex, onDuty: $onDuty, editMode: $editMode, currentPageTitle: $currentPageTitle, userName: $userName, phoneNumber: $phoneNumber, imageUrl: $imageUrl)';
  }
}
