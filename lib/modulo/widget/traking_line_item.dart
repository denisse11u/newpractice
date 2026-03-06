// import 'package:aplicacionflutter/widget/stage.dart';
// import 'package:flutter/material.dart';
// import 'package:aplicacionflutter/model/view_flows_response.dart';

// class TimelineItem extends StatelessWidget {
//   final Tracking tracking;
//   final bool isLast;

//   const TimelineItem({super.key, required this.tracking, this.isLast = false});

//   @override
//   Widget build(BuildContext context) {
//     final user = tracking.user;

//     final name = "${user?.firstName ?? ''} ${user?.lastName ?? ''}"
//         .trim()
//         .toUpperCase();

//     final date = tracking.createdAt?.toString() ?? "";

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// LINEA + CIRCULO
//         Column(
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.blue,
//               ),
//             ),

//             if (!isLast)
//               Container(width: 2, height: 60, color: Colors.grey.shade300),
//           ],
//         ),

//         const SizedBox(width: 12),

//         /// CONTENIDO
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Badge de estado
//               StageBadge(stage: tracking.descriptor),

//               const SizedBox(height: 6),

//               /// Usuario
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               /// Fecha
//               Text(
//                 date,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),

//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:aplicacionflutter/widget/stage.dart';
import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final Tracking tracking;
  final bool isLast;

  const TimelineItem({super.key, required this.tracking, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final user = tracking.user;

    final name = "${user?.firstName ?? ''} ${user?.lastName ?? ''}"
        .trim()
        .toUpperCase();

    final date = tracking.createdAt;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),

            if (!isLast)
              Expanded(child: Container(width: 2, color: Colors.grey.shade300)),
          ],
        ),

        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tracking.descriptor ?? "-",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  StageBadge(stage: tracking.stage?.showName),
                ],
              ),

              const SizedBox(height: 6),

              Text(name, style: const TextStyle(fontSize: 13)),

              const SizedBox(height: 2),

              Text(
                date?.toString() ?? "",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
