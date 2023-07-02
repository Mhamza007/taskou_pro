part of 'documents_cubit.dart';

class DocumentsState extends Equatable {
  const DocumentsState({
    this.loading = false,
    this.idProofFront,
    this.idProofBack,
    this.certificateFront,
    this.certificateBack,
    this.message = '',
    this.apiResponseStatus,
  });

  final bool loading;
  final String? idProofFront;
  final String? idProofBack;
  final String? certificateFront;
  final String? certificateBack;
  final String message;
  final ApiResponseStatus? apiResponseStatus;

  @override
  List<Object?> get props => [
        loading,
        idProofFront,
        idProofBack,
        certificateFront,
        certificateBack,
        message,
        apiResponseStatus,
      ];

  DocumentsState copyWith({
    bool? loading,
    String? idProofFront,
    String? idProofBack,
    String? certificateFront,
    String? certificateBack,
    String? message,
    ApiResponseStatus? apiResponseStatus,
  }) {
    return DocumentsState(
      loading: loading ?? this.loading,
      idProofFront: idProofFront ?? this.idProofFront,
      idProofBack: idProofBack ?? this.idProofBack,
      certificateFront: certificateFront ?? this.certificateFront,
      certificateBack: certificateBack ?? this.certificateBack,
      message: message ?? this.message,
      apiResponseStatus: apiResponseStatus ?? this.apiResponseStatus,
    );
  }
}
