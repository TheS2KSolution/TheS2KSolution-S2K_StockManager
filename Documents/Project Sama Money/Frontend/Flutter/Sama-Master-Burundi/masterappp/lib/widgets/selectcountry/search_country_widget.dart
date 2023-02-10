import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchCountry extends StatelessWidget {
  SearchCountry({Key? key, this.controller}) : super(key: key);

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 2.0, right: 8.0),
      child: Card(
        child: TextFormField(
          autofocus: true,
          controller: controller,
          decoration: const InputDecoration(
              hintText: 'Recherchez votre pays',
              contentPadding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
