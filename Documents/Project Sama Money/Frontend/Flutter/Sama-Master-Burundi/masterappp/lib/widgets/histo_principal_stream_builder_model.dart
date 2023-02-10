import 'package:flutter/material.dart';
import 'package:masterappp/models/histo_principale_model.dart';
import 'package:masterappp/widgets/progress_dialog.dart';

class HistoPrincipalListBuilder extends StatelessWidget {
  final Stream<List<HistoPrincipalModel>>? stream;
  final Function? builder;

  HistoPrincipalListBuilder({this.stream, this.builder});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<List<HistoPrincipalModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CustomCircularProgresssDialog();

            case ConnectionState.done:
              if (snapshot.hasData) {
                List<HistoPrincipalModel> oryxAchats = snapshot.data!;

                return builder!(context, oryxAchats);
              } else {
                List<HistoPrincipalModel> oryxAchats = [];
                return builder!(context, oryxAchats);
              }
          }
        });
  }
}
