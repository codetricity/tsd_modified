part of 'panorama_bloc.dart';

abstract class PanoramaEvent extends Equatable {
  const PanoramaEvent();

  @override
  List<Object> get props => [];
}

class IncrementPanoramaEvent extends PanoramaEvent {}

class ZeroPanoramaEvent extends PanoramaEvent {}
