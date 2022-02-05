import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/repository.dart';
import 'bloc_states/photo_state.dart';

abstract class PhotoEvent {}



class PhotoInitializedEvent extends PhotoEvent {}

class PhotoFetchEvent extends PhotoEvent {}

class PhotoDeleteEven extends PhotoEvent {
  final int index;
  PhotoDeleteEven({required this.index});
}

class PhotoUpdateEvent extends PhotoEvent {
  final String title;
  final int index;
  PhotoUpdateEvent({required this.title, required this.index});
}

class PhotoAPIEvent extends PhotoEvent {}

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(const PhotoState()) {
    on<PhotoFetchEvent>((event, emit) async {
      emit(state.copyWith(status: PhotoStateStatus.loading));
      try {
        final data = await Repository().getPhotoProfile();
        emit(state.copyWith(status: PhotoStateStatus.success, photoResponse: data));
      } catch (error) {
        emit(state.copyWith(status: PhotoStateStatus.error));
      }
    });
    on<PhotoDeleteEven>((event, emit) async {
      var data = state.photoResponse;
      data.removeAt(event.index);
      emit(state.copyWith(status: PhotoStateStatus.success,photoResponse: data));
    });
    on<PhotoUpdateEvent>((event, emit) => {});
  }
}
