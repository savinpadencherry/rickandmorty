// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'package:story/widgets/cardw.dart';

class RickAndMortyRepository {
  var _episodeService = EpisodeService();
  var _charactersService = CharacterService();
  var _locationClass = LocationService();
  List<SwipeItem> _cardView = [];
  List<SwipeItem> _LikeItems = [];
  List<SwipeItem> _UnLikeItems = [];

  void allEpisodes() async {
    List<Episode> episodes = await _episodeService.getAllEpisodes();
    episodes.forEach((episode) {
      dev.log('${episode.name}', name: "checking for episode names in repo");
    });
  }

  List<SwipeItem> get cardView {
    return _cardView;
  }

  List<SwipeItem> get likeItems {
    return _LikeItems;
  }

  List<SwipeItem> get unlikeItems {
    return _UnLikeItems;
  }

  allCharacters() async {
    List<Character> characters = await _charactersService.getFilteredCharacters(
      CharacterFilters(
          status: CharacterStatus.alive,
          species: CharacterSpecies.human,
          gender: CharacterGender.female),
    );
    characters.forEach((character) {
      dev.log('${character.name}',
          name: "Checking for characters name in repo");
      _cardView.add(
        SwipeItem(
            content: character,
            // Content(
            //     text: character.name,
            //     imageUrl: character.image,
            //     species: character.species,
            //     ),
            likeAction: () {
              dev.log('Liked',
                  name: 'Checking for like in Swipe item rickrepository');
              _LikeItems.add(
                SwipeItem(content: character
                    // Content(
                    //     text: character.name,
                    //     imageUrl: character.image,
                    //     species: character.species,
                    //     ),
                    ),
              );
            },
            nopeAction: () {
              dev.log("Unliked",
                  name: "Checking for unlike in Swipe item rickrepository");
              _UnLikeItems.add(
                SwipeItem(
                  content: character,
                  // Content(
                  //   text: character.name,
                  //   imageUrl: character.image,
                  //   species: character.species,
                  // ),
                ),
              );
            }),
      );
    });
  }

  void allLocation() async {
    List<Location> locations = await _locationClass.getAllLocations();
    locations.forEach((location) {
      dev.log('${location.name} , residents ${location.residents}',
          name: "Checking for location residents");
    });
  }
}

class Content {
  final String text;
  final String imageUrl;
  final String species;

  Content({
    required this.text,
    required this.imageUrl,
    required this.species,
  });
}
