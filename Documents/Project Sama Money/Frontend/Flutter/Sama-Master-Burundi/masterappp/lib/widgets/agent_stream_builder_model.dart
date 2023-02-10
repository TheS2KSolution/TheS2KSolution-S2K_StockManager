import 'package:flutter/material.dart';
import 'package:masterappp/models/agent_model.dart';
import 'package:masterappp/widgets/progress_dialog.dart';


class AgentListBuilder extends StatelessWidget {
  final Stream<List<AgentModel>>? stream;
  final Function? builder;

  AgentListBuilder({this.stream, this.builder});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<List<AgentModel>> snapshot) {
          // print(snapshot.data);

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CustomCircularProgresssDialog();

            case ConnectionState.done:
              if (snapshot.hasData) {
                List<AgentModel> agents = snapshot.data!;

                return builder!(context, agents);
              } else {
                List<AgentModel> agents = [];
                return builder!(context, agents);
              }
          }
        });
  }
}
