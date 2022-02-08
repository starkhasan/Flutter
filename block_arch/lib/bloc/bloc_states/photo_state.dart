import 'package:block_arch/models/photo_response.dart';

// abstract class PhotoState {}

// class PhotoInitializationState extends PhotoState {}

// class PhotoNetworkFailed extends PhotoState {}

// class PhotoFectchingData extends PhotoState {}

// class PhotoDataState extends PhotoState {
//   final List<PhotoResponse> photoResponse;
//   PhotoDataState({required this.photoResponse});
// }

//class PhotoErrorState extends PhotoState {}

enum PhotoStateStatus { initial, success, error, loading, selected }

extension PhotoStateStatusExtension on PhotoStateStatus {
  bool get isInitial => this == PhotoStateStatus.initial;
  bool get isSuccess => this == PhotoStateStatus.success;
  bool get isError => this == PhotoStateStatus.error;
  bool get isLoading => this == PhotoStateStatus.loading;
}

class PhotoState {
  final List<PhotoResponse> photoResponse;
  final int selected;
  final PhotoStateStatus status;
  final bool deleted;
  
  const PhotoState({
    this.photoResponse = const [],
    this.selected = 0,
    this.status = PhotoStateStatus.initial,
    this.deleted = false
  });


  PhotoState copyWith({
    List<PhotoResponse>? photoResponse,
    PhotoStateStatus? status,
    int? selected,
    bool? deleted
  }) {
    return PhotoState(
      photoResponse: photoResponse ?? this.photoResponse,
      status: status ?? this.status,
      selected: selected ?? this.selected,
      deleted: deleted ?? this.deleted
    );
  }

  // @override
  // List<Object?> get props => [photoResponse, selected, status]; 
}
