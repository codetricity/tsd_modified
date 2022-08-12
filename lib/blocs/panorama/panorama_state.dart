// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'panorama_bloc.dart';

class PanoramaState extends Equatable {
  final int urlIndex;
  const PanoramaState(
    this.urlIndex,
  );

  factory PanoramaState.initial() => const PanoramaState(0);

  @override
  List<Object> get props => [urlIndex];

  @override
  bool get stringify => true;

  PanoramaState copyWith({
    int? urlIndex,
  }) {
    return PanoramaState(
      urlIndex ?? this.urlIndex,
    );
  }
}
