import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:flutter/material.dart';

class FlowTrackingContent extends StatelessWidget {
  final ViewFlowsResponse flow;

  const FlowTrackingContent({super.key, required this.flow});

  @override
  Widget build(BuildContext context) {
    final events = flow.trackings ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: events.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("• ${e.descriptor}"),
        );
      }).toList(),
    );
  }
}
