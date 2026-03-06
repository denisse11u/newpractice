import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:aplicacionflutter/modulo/widget/involved_drop.dart';
import 'package:aplicacionflutter/modulo/widget/modal_base_widget.dart';
import 'package:aplicacionflutter/modulo/widget/tracking_widget.dart';
import 'package:flutter/material.dart';

class ModalTracking extends StatelessWidget {
  final List<Tracking> trackings;
  final List<Involved> involveds;

  const ModalTracking({
    super.key,
    required this.trackings,
    required this.involveds,
  });

  @override
  Widget build(BuildContext context) {
    return ModalBaseWidget(
      title: "Ver seguimiento",
      subtitle: "Acciones que se realizaron en este flujo",
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            InvolvedDropdown(involveds: involveds, onChanged: (inv) {}),

            const SizedBox(height: 20),

            Expanded(child: TimelineWidget(trackings: trackings)),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Confirmar seguimiento"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
