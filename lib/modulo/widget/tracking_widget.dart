import 'package:aplicacionflutter/modulo/widget/traking_line_item.dart';
import 'package:flutter/material.dart';
import 'package:aplicacionflutter/model/view_flows_response.dart';

class TimelineWidget extends StatelessWidget {
  final List<Tracking> trackings;

  const TimelineWidget({super.key, required this.trackings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(trackings.length, (index) {
        return TimelineItem(
          tracking: trackings[index],
          isLast: index == trackings.length - 1,
        );
      }),
    );
  }
}

// class TimelineWidget extends StatelessWidget {
//   final List<Tracking> trackings;

//   const TimelineWidget({
//     super.key,
//     required this.trackings,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: trackings.length,
//       itemBuilder: (context, index) {
//         return TimelineItem(
//           tracking: trackings[index],
//           isLast: index == trackings.length - 1,
//         );
//       },
//     );
//   }
// }
