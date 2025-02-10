import 'package:flutter/material.dart';
import 'package:home_for_new_year_game/models/person.dart';

class PersonView extends StatelessWidget {
  final Person person;
  final Function onTap;

  PersonView({required this.person, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Image.asset(
        person.imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}