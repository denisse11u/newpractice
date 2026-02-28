import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:flutter/material.dart';

class FlowDetailsContent extends StatelessWidget {
  final ViewFlowsResponse flow;

  const FlowDetailsContent({super.key, required this.flow});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nombre: ${flow.name ?? ''}"),
        const SizedBox(height: 8),
        Text("Estado: ${flow.stage?.name ?? ''}"),
        const SizedBox(height: 8),
        Text("Expira: ${flow.expiration ?? ''}"),
        const SizedBox(height: 12),
        const Text("Descripción del flujo aquí..."),
      ],
    );
  }
}
