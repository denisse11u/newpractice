// // import 'package:aplicacionflutter/model/flowcardmodel.dart';
// // import 'package:aplicacionflutter/widget/stage.dart';
// // import 'package:flutter/material.dart';

// // class FlowCard extends StatefulWidget {
// //   final FlowCardModel model;

// //   const FlowCard({super.key, required this.model});

// //   @override
// //   State<FlowCard> createState() => _FlowCardState();
// // }

// // class _FlowCardState extends State<FlowCard>
// //     with SingleTickerProviderStateMixin {
// //   bool _isExpanded = false;

// //   void _toggle() {
// //     setState(() {
// //       _isExpanded = !_isExpanded;
// //     });
// //   }

// //   String _formatDate(DateTime? date) {
// //     if (date == null) return "Sin fecha";
// //     return "${date.day}/${date.month}/${date.year}";
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final stageType = mapStage(widget.model.stage);

// //     return AnimatedContainer(
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //       margin: const EdgeInsets.symmetric(vertical: 10),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(22),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(.06),
// //             blurRadius: 15,
// //             offset: const Offset(0, 8),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           InkWell(
// //             borderRadius: BorderRadius.circular(22),
// //             onTap: _toggle,
// //             child: Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Row(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         StageBadge(stage: stageType),
// //                         const SizedBox(height: 12),
// //                         Text(
// //                           widget.model.title,
// //                           style: const TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8),
// //                         Row(
// //                           children: [
// //                             const Icon(Icons.calendar_today, size: 16),
// //                             const SizedBox(width: 6),
// //                             Text(
// //                               "Expira: ${_formatDate(widget.model.expiration)}",
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 6),
// //                         Row(
// //                           children: [
// //                             const Icon(Icons.group, size: 16),
// //                             const SizedBox(width: 6),
// //                             Text("${widget.model.participants} participantes"),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   AnimatedRotation(
// //                     duration: const Duration(milliseconds: 300),
// //                     turns: _isExpanded ? 0.5 : 0,
// //                     child: const Icon(Icons.keyboard_arrow_down),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           /// CONTENIDO EXPANDIBLE
// //           AnimatedCrossFade(
// //             duration: const Duration(milliseconds: 300),
// //             crossFadeState: _isExpanded
// //                 ? CrossFadeState.showSecond
// //                 : CrossFadeState.showFirst,
// //             firstChild: const SizedBox.shrink(),
// //             secondChild: Padding(
// //               padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Divider(),
// //                   const SizedBox(height: 10),
// //                   Text(
// //                     widget.model.description,
// //                     style: const TextStyle(color: Colors.black54),
// //                   ),
// //                   const SizedBox(height: 20),

// //                   /// BOTONES
// //                   SizedBox(
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       onPressed: () {},
// //                       style: ElevatedButton.styleFrom(
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(30),
// //                         ),
// //                       ),
// //                       child: const Text("Actualizar"),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 10),

// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: OutlinedButton(
// //                           onPressed: () {},
// //                           child: const Text("Detalles"),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 10),
// //                       Expanded(
// //                         child: OutlinedButton(
// //                           onPressed: () {},
// //                           child: const Text("Seguimiento"),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:aplicacionflutter/model/view_flows_response.dart';
// import 'package:flutter/material.dart';

// class FlowCard extends StatelessWidget {
//   final ViewFlowsResponse flow;

//   const FlowCard({super.key, required this.flow});

//   String _formatDate(DateTime? date) {
//     if (date == null) return "Sin fecha";
//     return "${date.day}/${date.month}/${date.year}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final participants = flow.involveds?.length ?? 0;
//     final stage = flow.stage?.name ?? 'desconocido';

//     return Card(
//       child: ListTile(
//         title: Text(flow.name ?? 'Sin título'),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Expira: ${_formatDate(flow.expiration)}"),
//             Text("$participants participantes"),
//             Text("Estado: $stage"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:aplicacionflutter/modulo/widget/FlowDetailsContent.dart';
import 'package:aplicacionflutter/modulo/widget/FlowTrackingContent.dart';
import 'package:aplicacionflutter/widget/avatarparticipantes.dart';
import 'package:aplicacionflutter/widget/modalglobal.dart';
import 'package:flutter/material.dart';

class FlowCard extends StatefulWidget {
  final ViewFlowsResponse flow;

  const FlowCard({super.key, required this.flow});

  @override
  State<FlowCard> createState() => _FlowCardState();
}

class _FlowCardState extends State<FlowCard> {
  bool _isExpanded = false;

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Sin fecha";
    return "${date.day}/${date.month}/${date.year}";
  }

  Color _stageColor(String? stage) {
    switch (stage?.toLowerCase()) {
      case 'activo':
        return Colors.blue;
      case 'pendiente':
        return Colors.orange;
      case 'rechazado':
        return Colors.red;
      case 'completado':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    void _openModal(BuildContext context, String title, Widget body) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => AppFlowModal(title: title, body: body),
      );
    }

    final flow = widget.flow;
    final participants = flow.involveds?.length ?? 0;
    final stage = flow.stage?.name ?? "Desconocido";
    final stageColor = _stageColor(stage);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: stageColor.withOpacity(.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            stage.toUpperCase(),
                            style: TextStyle(
                              color: stageColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Title
                        Text(
                          flow.name ?? "Sin título",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 6),
                            Text("Expira: ${_formatDate(flow.expiration)}"),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(Icons.group, size: 16),
                            const SizedBox(width: 6),
                            Text("$participants participantes"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isExpanded ? 0.5 : 0,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),

          /// EXPANDIBLE
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 10),

                  const Text(
                    "Descripción del flujo:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    "Este flujo corresponde al proceso interno definido por la organización.",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 16),

                  ParticipantsAvatars(
                    names: const [
                      "Juan Diaz",
                      "Ana Martinez",
                      "Pedro mmm",
                      "Maria Gomez",
                      "Carlos Ruiz",
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Actualizar"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _openModal(
                              context,
                              "Detalles",
                              FlowDetailsContent(flow: flow),
                            );
                          },
                          child: const Text("Detalles"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _openModal(
                              context,
                              "Seguimiento",
                              FlowTrackingContent(flow: flow),
                            );
                          },
                          child: const Text("Seguimiento"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
