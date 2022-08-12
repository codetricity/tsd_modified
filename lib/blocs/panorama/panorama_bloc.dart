import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'panorama_event.dart';
part 'panorama_state.dart';

class PanoramaBloc extends Bloc<PanoramaEvent, PanoramaState> {
  PanoramaBloc() : super(PanoramaState.initial()) {
    on<IncrementPanoramaEvent>((event, emit) {
      emit(state.copyWith(urlIndex: state.urlIndex + 1));
    });
    on<ZeroPanoramaEvent>((event, emit) {
      emit(state.copyWith(urlIndex: 0));
    });
  }
}
