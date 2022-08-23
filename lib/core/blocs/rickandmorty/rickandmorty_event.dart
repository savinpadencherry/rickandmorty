part of 'rickandmorty_bloc.dart';

abstract class RickandmortyEvent extends Equatable {
  const RickandmortyEvent();

  @override
  List<Object> get props => [];
}

class OnAppStartEvent extends RickandmortyEvent {}
