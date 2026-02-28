import 'package:flutter/material.dart';

enum FlowStageType {
  activo,
  rechazado,
  pendiente,
  completado,
  expirado,
  anulado,
  desconocido,
}

FlowStageType mapStage(String? stage) {
  switch (stage?.toLowerCase()) {
    case 'activo':
      return FlowStageType.activo;
    case 'rechazado':
      return FlowStageType.rechazado;
    case 'pendiente':
      return FlowStageType.pendiente;
    case 'completado':
      return FlowStageType.completado;
    case 'expirado':
      return FlowStageType.expirado;
    case 'anulado':
      return FlowStageType.anulado;
    default:
      return FlowStageType.desconocido;
  }
}

class StageBadge extends StatelessWidget {
  final FlowStageType stage;

  const StageBadge({super.key, required this.stage});

  Color _backgroundColor() {
    switch (stage) {
      case FlowStageType.activo:
        return Colors.blue.shade100;
      case FlowStageType.rechazado:
        return Colors.red.shade100;
      case FlowStageType.pendiente:
        return Colors.orange.shade100;
      case FlowStageType.completado:
        return Colors.green.shade100;
      case FlowStageType.expirado:
        return Colors.grey.shade300;
      case FlowStageType.anulado:
        return Colors.black12;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _textColor() {
    switch (stage) {
      case FlowStageType.activo:
        return Colors.blue.shade800;
      case FlowStageType.rechazado:
        return Colors.red.shade800;
      case FlowStageType.pendiente:
        return Colors.orange.shade800;
      case FlowStageType.completado:
        return Colors.green.shade800;
      case FlowStageType.expirado:
        return Colors.grey.shade700;
      case FlowStageType.anulado:
        return Colors.black87;
      default:
        return Colors.grey.shade700;
    }
  }

  String _label() {
    return stage.name.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label(),
        style: TextStyle(color: _textColor(), fontWeight: FontWeight.w600),
      ),
    );
  }
}
