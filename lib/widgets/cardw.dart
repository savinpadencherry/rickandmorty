import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class SwipeItemDesign extends StatelessWidget {
  final Character imageUrl;
  final Character name;
  final Character species;
  const SwipeItemDesign({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.species,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 3),
                blurRadius: 15,
                spreadRadius: 1,
                color: Colors.grey)
          ]),
      child: Stack(
        children: [
          Image.network(
            imageUrl.image,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 208.0),
            child: Column(
              children: [
                Text(
                  name.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  species.species,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
