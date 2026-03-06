import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:flutter/material.dart';

class CardsWidget extends StatefulWidget {
  final ViewFlowsResponse flow;

  const CardsWidget({super.key, required this.flow});

  @override
  State<CardsWidget> createState() => _FlowCardState();
}

class _FlowCardState extends State<CardsWidget> {
  bool _isExpanded = false;

  void _toggle() => setState(() => _isExpanded = !_isExpanded);
  int get participants => widget.flow.involveds?.length ?? 0;

  String get stage => widget.flow.stage?.showName ?? "Desconocido";

  String get type => widget.flow.type?.showName ?? "-";

  void _openModal(Widget modal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => modal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final flow = widget.flow;
    // final participants = flow.involveds?.length ?? 0;
    // final stage = flow.stage?.showName ?? "Desconocido";
    // final type = flow.type?.showName ?? "-";

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: AppTheme.bordergrey, width: 0.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StageBadge(stage: stage),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: _isExpanded ? 0.5 : 0,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              "${flow.name}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),

                            InfoRow(
                              icon: Icons.event_busy,
                              iconColor: AppTheme.massive,
                              iconSize: 20,

                              labelWidget: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'F.E: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          flow.expiration?.toString().split(
                                            ' ',
                                          )[0] ??
                                          '-',
                                    ),
                                  ],
                                ),
                              ),
                              label: '',
                            ),
                            const SizedBox(height: 6),

                            InfoRow(
                              icon: Icons.filter_list_alt,
                              iconSize: 20,
                              iconColor: AppTheme.confirmCard,

                              labelWidget: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Tipo: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: '${type}'),
                                  ],
                                ),
                              ),
                              label: '',
                            ),
                            const SizedBox(height: 6),
                            InfoRow(
                              icon: Icons.group,
                              iconSize: 20,
                              iconColor: AppTheme.textColorSupport,
                              label: "$participants Involucrados",
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ParticipantsAvatars(
                          involveds: widget.flow.involveds ?? [],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: !_isExpanded
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const Text(
                          'Ver Detalles',
                          style: TextStyle(
                            color: AppTheme.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButtonWidget(
                                icon: Icons.picture_as_pdf,
                                borderColor: AppTheme.error,
                                iconColor: AppTheme.error,
                                textColor: AppTheme.error,
                                label: 'Ver archivos',
                                onPressed: () => _openModal(ViewPdf()),
                              ),
                            ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: OutlinedButtonWidget(
                                Expanded(
                                  child: OutlinedButtonWidget(
                                    icon: Icons.pending_actions,
                                    borderColor: AppTheme.seeTracking,
                                    iconColor: AppTheme.seeTracking,
                                    textColor: AppTheme.seeTracking,
                                    label: 'Ver Seguimiento',
                                    onPressed: () {
                                      _openModal(
                                        ModalTracking(
                                          trackings: flow.trackings ?? [],
                                          involveds: flow.involveds ?? [],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            OutlinedButtonWidget(
                              icon: Icons.group,
                              borderColor: AppTheme.cautionCard,
                              iconColor: AppTheme.textCard,
                              textColor: AppTheme.textPrimary,
                              label: 'Involucrados',
                              onPressed: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => ModalInvolveds(
                                  involveds: flow.involveds ?? [],
                                  actions: [],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Divider(),
                        Text(
                          'Acciones',
                          style: TextStyle(
                            color: AppTheme.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButtonWidget(
                                icon: Icons.visibility,
                                borderColor: AppTheme.textSecondary,
                                width: 200,
                                iconColor: AppTheme.textSecondary,
                                textColor: AppTheme.textSecondary,
                                onPressed: () {},

                                label: 'Ver flujo',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButtonWidget(
                                icon: Icons.settings,
                                borderColor: AppTheme.update,
                                width: 200,
                                iconColor: AppTheme.update,
                                textColor: AppTheme.update,
                                onPressed: () {},

                                label: 'Configuracion',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButtonWidget(
                                icon: Icons.history_edu,
                                borderColor: AppTheme.sucess,
                                iconColor: AppTheme.sucess,
                                textColor: AppTheme.sucess,
                                onPressed: () {},
                                label: 'Usar plantilla',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButtonWidget(
                                icon: Icons.layers,
                                borderColor: AppTheme.massive,
                                iconColor: AppTheme.massive,
                                textColor: AppTheme.massive,
                                onPressed: () {},
                                label: 'Crear masivo',
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: OutlinedButtonWidget(
                            icon: Icons.layers,
                            width: 300,
                            onPressed: () {},
                            label: 'Crear masivo usando base',
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? labelWidget;
  final double iconSize;
  final Color? iconColor;
  final TextStyle? textStyle;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    this.iconSize = 16,
    this.iconColor,
    this.textStyle,
    this.labelWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        const SizedBox(width: 6),
        Flexible(child: labelWidget ?? Text(label, style: textStyle)),
      ],
    );
  }
}
