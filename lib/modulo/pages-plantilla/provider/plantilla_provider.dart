import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viadoc_app/modules/create_flow/services/create_flow_services.dart';

final createFlowServicesProvider = Provider((ref) => CreateFlowServices(ref));
