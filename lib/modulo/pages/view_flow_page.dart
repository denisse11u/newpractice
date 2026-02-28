// import 'package:aplicacionflutter/model/flowcardmodel.dart';
// import 'package:aplicacionflutter/model/view_flows_response.dart';
// import 'package:aplicacionflutter/widget/card.dart';
// import 'package:flutter/material.dart';

// class ViewFlowsPage extends StatelessWidget {
//   const ViewFlowsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final demoFlows = [
//       ViewFlowsResponse(
//         // id: "1",
//         // title: "Flujo de Aprobación de Gastos",
//         // category: "Administrativo",
//         name: 'prueba1',
//         expiration: DateTime(2026, 10, 12),
//         // participants: 5,
//         stage: Stage(name: 'aceptado'),
//         // description:
//         //     "Este flujo gestiona solicitudes de reembolso y requiere aprobación del gerente y finanzas.",
//       ),
//       FlowCardModel(
//         id: "2",
//         title: "Mantenimiento Preventivo",
//         category: "Operativo",
//         expiration: DateTime(2025, 12, 5),
//         participants: 3,
//         stage: "pendiente",
//         description:
//             "Supervisión periódica del mantenimiento de equipos críticos.",
//       ),
//       FlowCardModel(
//         id: "3",
//         title: "Onboarding Nuevos Talentos",
//         category: "RRHH",
//         expiration: DateTime(2026, 8, 20),
//         participants: 12,
//         stage: "rechazado",
//         description: "Proceso de incorporación de nuevos colaboradores.",
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6FA),
//       appBar: AppBar(title: const Text("Gestión de Flujos"), elevation: 0),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: demoFlows.length,
//         itemBuilder: (_, index) {
//           return FlowCard(model: demoFlows[index], flow: null,);
//         },
//       ),
//     );
//   }
// }

import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:aplicacionflutter/widget/card.dart';
import 'package:flutter/material.dart';

class ViewFlowsPage extends StatelessWidget {
  const ViewFlowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flows = [
      ViewFlowsResponse(
        // id: "3",
        name: "Onboarding Nuevos Talentos",
        expiration: DateTime(2026, 8, 20),
        // involveds: [1, 2, 3, 4, 5],
        stage: Stage(name: "Rechazado"),
      ),
      ViewFlowsResponse(
        // id: "3",
        name: "Onboarding Nuevos Talentos",
        expiration: DateTime(2026, 8, 20),
        // involveds: [1, 2, 3, 4, 5],
        stage: Stage(name: "aceptado"),
      ),
      ViewFlowsResponse(
        // id: "3",
        name: "Onboarding Nuevos Talentos",
        expiration: DateTime(2026, 8, 20),
        // involveds: [1, 2, 3, 4, 5],
        stage: Stage(name: "pendiente"),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(title: const Text("Gestión de Flujos")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: flows.length,
        itemBuilder: (context, index) {
          return FlowCard(flow: flows[index]);
        },
      ),
    );
  }
}
