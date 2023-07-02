part of 'tracking_cubit.dart';

class TrackingState extends Equatable {
  const TrackingState({
    this.loading = false,
    this.arrived = false,
    this.tracking = false,
    this.message = '',
    this.apiResponseStatus,
    this.initialCameraPosition = const CameraPosition(target: LatLng(0, 0)),
    this.googleMapController,
    this.zoom = 15.0,
    this.markers = const <Marker>{},
    this.polylines = const <Polyline>{},
    this.userName,
    this.address,
  });

  final bool loading;
  final bool arrived;
  final bool tracking;
  final String message;
  final ApiResponseStatus? apiResponseStatus;
  final CameraPosition initialCameraPosition;
  final GoogleMapController? googleMapController;
  final double zoom;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final String? userName;
  final String? address;

  @override
  List<Object?> get props => [
        loading,
        arrived,
        tracking,
        message,
        apiResponseStatus,
        initialCameraPosition,
        googleMapController,
        zoom,
        markers,
        polylines,
        userName,
        address,
      ];

  TrackingState copyWith({
    bool? loading,
    bool? arrived,
    bool? tracking,
    String? message,
    ApiResponseStatus? apiResponseStatus,
    CameraPosition? initialCameraPosition,
    GoogleMapController? googleMapController,
    double? zoom,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    String? userName,
    String? address,
  }) {
    return TrackingState(
      loading: loading ?? this.loading,
      arrived: arrived ?? this.arrived,
      tracking: tracking ?? this.tracking,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
      initialCameraPosition:
          initialCameraPosition ?? this.initialCameraPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      zoom: zoom ?? this.zoom,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      userName: userName ?? this.userName,
      address: address ?? this.address,
    );
  }
}
