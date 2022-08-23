// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'rickandmorty_bloc.dart';

class RickandmortyState extends Equatable {
  final String? dataStatus;
  final List<SwipeItem>? swipeItem;
  const RickandmortyState({
    this.dataStatus,
    this.swipeItem,
  });

  factory RickandmortyState.initial() {
    return RickandmortyState(dataStatus: "", swipeItem: []);
  }

  @override
  List<Object?> get props => [dataStatus, swipeItem];

  RickandmortyState copyWith({
    String? dataStatus,
    List<SwipeItem>? swipeItem,
  }) {
    return RickandmortyState(
      dataStatus: dataStatus ?? this.dataStatus,
      swipeItem: swipeItem ?? this.swipeItem,
    );
  }

  @override
  bool get stringify => true;
}
