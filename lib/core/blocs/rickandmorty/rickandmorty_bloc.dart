// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'package:story/constants/constants.dart';
import 'package:story/core/repository/rickandmortyrepo.dart';

part 'rickandmorty_event.dart';
part 'rickandmorty_state.dart';

class RickandmortyBloc extends Bloc<RickandmortyEvent, RickandmortyState> {
  final RickAndMortyRepository rickAndMortyRepository;
  RickandmortyBloc({
    required this.rickAndMortyRepository,
  }) : super(RickandmortyState.initial()) {
    on<RickandmortyEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnAppStartEvent>((event, emit) async {
      emit(state.copyWith(
        dataStatus: Constants.dataLoading,
      ));
      try {
        await rickAndMortyRepository.allCharacters();
        emit(state.copyWith(dataStatus: Constants.dataReceivedAndMapped));
      } catch (e) {
        emit(state.copyWith(dataStatus: Constants.dataLoadingFailureDue));
      }
    });
  }
}
