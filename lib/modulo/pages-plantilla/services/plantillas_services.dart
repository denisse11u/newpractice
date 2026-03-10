import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viadoc_app/modules/create_flow/models/create_flow_request.dart';
import 'package:viadoc_app/shared/helpers/global_helper.dart';
import 'package:viadoc_app/shared/models/general_response.dart';
import 'package:viadoc_app/shared/services/http_interceptor.dart';

class CreateFlowServices {
  final Ref ref;
  final InterceptorHttp _interceptorHttp = InterceptorHttp();

  CreateFlowServices(this.ref);

  // ✅ Si el endpoint cambia, solo toca esta línea
  static const String _endpoint = '/signingflow';

  Future<GeneralResponse> createFlow(
    BuildContext context,
    CreateFlowRequest request, {
    bool showLoading = true,
  }) async {
    try {
      final GeneralResponse resp = await _interceptorHttp.request(
        ref,
        context,
        'POST',
        _endpoint,
        request.toJson(),
        showLoading: showLoading,
      );

      return resp;
    } catch (e, stacktrace) {
      GlobalHelper.logger.e('metodo createFlow $e $stacktrace');
      return GeneralResponse(message: 'Error al crear el flujo', result: false);
    }
  }
}
