import 'package:aplicacionflutter/model/view_flows_response.dart';

enum FlowFilterType {
  signingFlowId,
  signingFlowBaseId,
  name,
  type,
  stage,
  involvedFirstName,
  involvedLastName,
  involvedEmail,
  involvedIdentification,
}

extension FlowFilterTypeLabel on FlowFilterType {
  String get label {
    switch (this) {
      case FlowFilterType.signingFlowId:
        return 'Id del flujo';
      case FlowFilterType.signingFlowBaseId:
        return 'Id del flujo base';
      case FlowFilterType.name:
        return 'Nombre';
      case FlowFilterType.type:
        return 'Tipo';
      case FlowFilterType.stage:
        return 'Etapa';
      case FlowFilterType.involvedFirstName:
        return 'Nombres de involucrado';
      case FlowFilterType.involvedLastName:
        return 'Apellido de involucrado';
      case FlowFilterType.involvedEmail:
        return 'Correo electrónico de involucrado';
      case FlowFilterType.involvedIdentification:
        return 'Identificación de involucrado';
    }
  }
}

String getFilterValue(ViewFlowsResponse flow, FlowFilterType filter) {
  switch (filter) {
    case FlowFilterType.signingFlowBaseId:
      return flow.signingFlowId ?? '';

    case FlowFilterType.name:
      return flow.name ?? '';

    case FlowFilterType.type:
      return flow.type?.name ?? '';

    case FlowFilterType.stage:
      return flow.stage?.name ?? '';

    case FlowFilterType.involvedFirstName:
      return flow.involveds?.map((e) => e.user?.firstName ?? '').join(' ') ??
          '';

    case FlowFilterType.involvedLastName:
      return flow.involveds?.map((e) => e.user?.lastName ?? '').join(' ') ?? '';

    default:
      return '';
  }
}
