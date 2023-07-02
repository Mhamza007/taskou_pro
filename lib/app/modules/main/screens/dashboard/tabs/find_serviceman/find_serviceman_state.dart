part of 'find_serviceman_cubit.dart';

class FindServicemanState extends Equatable {
  const FindServicemanState({
    this.initialCameraPosition = const CameraPosition(target: LatLng(0, 0)),
    this.googleMapController,
    this.zoom = 15.0,
    this.loading = true,
    this.message = '',
    this.apiResponseStatus,
  });

  final bool loading;
  final CameraPosition initialCameraPosition;
  final GoogleMapController? googleMapController;
  final double zoom;
  final String message;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        initialCameraPosition,
        googleMapController,
        zoom,
        loading,
        message,
        apiResponseStatus,
      ];

  FindServicemanState copyWith({
    CameraPosition? initialCameraPosition,
    GoogleMapController? googleMapController,
    double? zoom,
    bool? loading,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return FindServicemanState(
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      zoom: zoom ?? this.zoom,
      loading: loading ?? this.loading,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
