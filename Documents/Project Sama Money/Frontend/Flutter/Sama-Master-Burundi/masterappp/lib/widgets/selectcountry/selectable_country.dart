import 'package:flutter/material.dart';
import 'package:masterappp/models/countries.dart';

// ignore: must_be_immutable
class SelectableWidget extends StatelessWidget {
  SelectableWidget({Key? key, this.country, this.selectThisCountry})
      : super(key: key);

  Country? country;
  Function? selectThisCountry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      type: MaterialType.canvas,
      child: InkWell(
        onTap: () => selectThisCountry!(country), //selectThisCountry(country),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          child: Text(
            "  " +
                country!.flag! +
                "  " +
                country!.name! +
                " (" +
                country!.dialCode! +
                ")",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
