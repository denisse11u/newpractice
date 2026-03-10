import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class InterceptorHttp {
  static final InterceptorHttp _instance = InterceptorHttp._internal();
  factory InterceptorHttp() => _instance;

  InterceptorHttp._internal();

  int activeRequests = 0;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  Future<GeneralResponse> request(
    Ref ref,
    BuildContext context,
    String method,
    String urlEndPoint,
    dynamic body, {
    bool showLoading = true,
    bool isWithoutToken = false,
    Map<String, dynamic>? queryParameters,
    List<http.MultipartFile>? multipartFiles,
    Map<String, String>? multipartFields,
    String requestType = "JSON",
    int timeout = 60,
    Function(int sentBytes, int totalBytes)? onProgressLoad,
    List<http.MultipartFile>? originalMultipartFiles,
  }) async {
    var logger =
        Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));
    final urlService = Environment().config?.serviceUrl ?? "no url";

    String url = "$urlService$urlEndPoint";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      url += "?${Uri(queryParameters: queryParameters).query}";
    }

    logger.t('URL: $url');
    body != null
        ? logger.log(Level.warning, 'body: ${json.encode(body)}')
        : null;



    GeneralResponse generalResponse =
        GeneralResponse(data: null, message: "", result: false);

    final fp = ref.read(functionalProvider.notifier);

    final keyLoading = GlobalHelper.genKey();
    final keyError = GlobalHelper.genKey();


    String? messageButton;
    void Function()? onPress;

    try {
      activeRequests++;
      http.Response response;
      Uri uri = Uri.parse(url);

      log('$activeRequests');
      if (showLoading && activeRequests == 1) {
        debugPrint("KeyLoading del interceptor: $keyLoading");
        fp.showAlert(key: keyLoading, content: const AlertLoading());
        await Future.delayed(const Duration(milliseconds: 600));

      }

      //? Envio de TOKEN
      LoginResponse? userData = await SecurityStorage().getUserData();

      String tokenSesion = "";

      if (userData != null) {
        log('userdata ${jsonEncode(userData)}');
        tokenSesion = userData.token!;
      }

      //PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final ip = await GlobalHelper.getIpWifi();

      Map<String, String> headers = {
        "Authorization": (requestType == 'JSON')
            ? 'Bearer $tokenSesion'
            : 'Bearer $tokenSesion',
        "Content-Type": "application/json",
        "Origin": "http://$ip"
      };

      Map<String, String> headersWithoutToken = {
        "Content-Type": "application/json",
      };

      int responseStatusCode = 0;
      String responseBody = "";

      switch (requestType) {
        case "JSON":
          switch (method) {
            case "POST":
              response = await http
                  .post(uri,
                      headers: isWithoutToken ? headersWithoutToken : headers,
                      body: body != null ? json.encode(body) : null)
                  .timeout(Duration(seconds: timeout));
              print(headers);
              //inspect(_response);
              break;
            case "GET":
              response = await http
                  .get(
                    uri,
                    headers: isWithoutToken ? headersWithoutToken : headers,
                  )
                  .timeout(Duration(seconds: timeout));
              print(headers);
              break;
            case "PUT":
              response = await http
                  .put(uri,
                      headers: headers,
                      body: body != null ? json.encode(body) : null)
                  .timeout(Duration(seconds: timeout));
              break;
            case "PATCH":
              response = await http.patch(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
              break;
            case "DELETE":
              response = await http.delete(uri,
                  headers: headers,
                  body: body != null ? json.encode(body) : null);
            default:
              response = await http.post(uri, body: jsonEncode(body));
              break;
          }
          responseBody = response.body;
          responseStatusCode = response.statusCode;
          // responseStatusCode = json.decode(responseBody)["statusCode"];

        logger.log(Level.trace, json.decode(responseBody));

          break;
        case "FORM":
          final httpClient = getHttpClient();
          final request = await httpClient.postUrl(Uri.parse(url));
       
          int byteCount = 0;
          var requestMultipart = http.MultipartRequest(method, Uri.parse(url));
         

          headers.forEach((key, value) {
            request.headers.set("Authorization", 'Bearer $tokenSesion');
          });

          debugPrint("TOKEN CARGADO");

          List<http.MultipartFile>? filesToUse = originalMultipartFiles ?? multipartFiles;
          List<http.MultipartFile>? clonedFiles;

          if (filesToUse != null && filesToUse.isNotEmpty) {
            clonedFiles = await cloneMultipartFiles(filesToUse);
            requestMultipart.files.addAll(clonedFiles);
            GlobalHelper.logger.w(requestMultipart.files.first.contentType);
          }
          if (multipartFields != null) {
            requestMultipart.fields.addAll(multipartFields);
          }

          var msStream = requestMultipart.finalize();

          var totalByteLength = requestMultipart.contentLength;

          request.contentLength = totalByteLength;

          request.headers.set(HttpHeaders.contentTypeHeader,
              requestMultipart.headers[HttpHeaders.contentTypeHeader]!);
          GlobalHelper.logger.w(request.headers);
          Stream<List<int>> streamUpload = msStream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onProgressLoad != null) {
                  onProgressLoad(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                generalResponse.result = false;
                throw error;
              },
              handleDone: (sink) {
                sink.close();
              },
            ),
          );

          await request.addStream(streamUpload);

          final httpResponse = await request.close();
          var statusCode = httpResponse.statusCode;

          responseStatusCode = statusCode;
          if (statusCode ~/ 100 != 2) {
            String serverErrorResponse =
                await utf8.decoder.bind(httpResponse).join();
            responseBody = serverErrorResponse;
            GlobalHelper.logger.w('Error response body: $serverErrorResponse');

          } else {
            await for (var data in httpResponse.transform(utf8.decoder)) {
              responseBody = data;
              print('response: $responseBody');
            }
          }
          break;
      }

      logger.t('statusCode: ${responseStatusCode.toString()}');

      switch (responseStatusCode) {
        case 200:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          generalResponse.result = true;
          generalResponse.message = responseDecoded["message"];
          fp.dismissAlert(key: keyLoading);
  
          break;
        case 201:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          generalResponse.result = true;
          generalResponse.message = responseDecoded["message"];
          fp.dismissAlert(key: keyLoading);
          break;
        case 204:
          var responseDecoded = json.decode(responseBody);
          generalResponse.data = responseDecoded["data"];
          generalResponse.result = true;
          generalResponse.message = responseDecoded["message"];
          fp.dismissAlert(key: keyLoading);

          break;
        case 307:
          generalResponse.result = false;
          generalResponse.message =
              "Ocurrió un error al consultar con los servicios. Intente con una red que le permita el acceso";
          fp.dismissAlert(key: keyLoading);
          break;
        case 400:
          var responseDecoded = json.decode(responseBody);
          generalResponse.result = false;
          final message = responseDecoded["message"];
          generalResponse.message = (message is List)
              ? 'Ocurrió un error al procesar esta solicitud: ${message.first}'
              : message;
          fp.dismissAlert(key: keyLoading);
          break;
        case 401:
          log("isRefreshing ${!_isRefreshing}");
          if (!_isRefreshing) {
            // _isRefreshing = true;
            // _refreshCompleter = Completer<void>();

            // RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest();
            // refreshTokenRequest.refreshToken = userData?.refresh ?? '';

            // await RefreshTokenService().refreshToken(context, refreshTokenRequest);

            // _refreshCompleter!.complete();
            // _isRefreshing = false;
          } else {

            await _refreshCompleter!.future;
          }

          generalResponse.result = true;
          fp.dismissAlert(key: keyLoading);
          log('Reintentar Petición: $urlEndPoint $queryParameters  $method $body $requestType');
          log('multipartfile ${multipartFiles != null}');

          List<http.MultipartFile>? freshFiles;
          if (multipartFiles != null && multipartFiles.isNotEmpty) {
            freshFiles = await cloneMultipartFiles(multipartFiles);
          }

          return request(
            ref, 
            context,
            method,
            urlEndPoint,
            body,
            requestType: requestType,
            multipartFiles: freshFiles,
            queryParameters: queryParameters,
            originalMultipartFiles: multipartFiles
          );

        case 403:
          generalResponse.message =
              'Su sesión ha caducado, vuelva a iniciar sesión.';
          generalResponse.result = false;
          messageButton = 'Volver a ingresar';
          onPress = () async {
            fp.clearAllAlert();
            log('al login');
            Navigator.pushAndRemoveUntil(context, GlobalHelper.navigationFadeIn(context, const LoginPage()),
                (route) =>
                    false); //Navigator.pushReplacement(context, GlobalHelper.navigationFadeIn(context, const LoginPage()));
            // await SecurityStorage().removeUserData();
            // await SecurityStorage().removeUserCredentials();
            //fp.dismissAlert(key: LayoutHomeWidget.keyModalProfile);
          };
          fp.dismissAlert(key: keyLoading);
          break;
        case 404:
          if (_isRefreshing) {
            _refreshCompleter!.complete();
            _isRefreshing = false;
            generalResponse.message =
                'Error al refrescar el token, vuelva a iniciar sesión.';
            generalResponse.result = false;
            messageButton = 'Volver a ingresar';
            onPress = () async {
              fp.clearAllAlert();
              Navigator.pushAndRemoveUntil(
                  context,
                  GlobalHelper.navigationFadeIn(context, const LoginPage()),
                  (route) =>
                      false); //Navigator.pushReplacement(context, GlobalHelper.navigationFadeIn(context, const LoginPage()));
              await SecurityStorage().removeUserData();
            };
          } else {
            generalResponse.result = false;
            generalResponse.message = json.decode(responseBody)["message"];
            // generalResponse.message = "Ocurrió un error al consultar con los servicios. Contáctese con el administrador";
            fp.dismissAlert(key: keyLoading);
          }

          break;

        case 500:
          generalResponse.result = false;
          generalResponse.message = json.decode(responseBody)["message"];
          fp.dismissAlert(key: keyLoading);
          break;
        default:
          generalResponse.result = false;
          generalResponse.message = json.decode(responseBody)["message"];
          fp.dismissAlert(key: keyLoading);
          break;
      }
    } on TimeoutException catch (e) {
      debugPrint('$e');
      generalResponse.result = false;
      generalResponse.message =
          'Tiempo de conexión excedido, inténtelo de nuevo.';
      fp.dismissAlert(key: keyLoading);
    } on FormatException catch (ex) {
      generalResponse.result = false;
      generalResponse.message =
          "Ocurrió un error al consultar el servicio. Contáctese con el administrador";
      debugPrint(ex.toString());
      fp.dismissAlert(key: keyLoading);
    } on SocketException catch (exSock) {
      logger.e("Error por conexion: $exSock");
      generalResponse.result = false;
      generalResponse.message =
          "Verifique su conexión a internet y vuelva a intentar.";
      fp.dismissAlert(key: keyLoading);
      onPress = () {
        fp.clearAllAlert();
      };
    } on Exception catch (e, stacktrace) {
      logger.e("Error en request: $stacktrace");
      generalResponse.result = false;
      generalResponse.message = "Ocurrio un error, vuelva a intentarlo.";
      fp.dismissAlert(key: keyLoading);
    } finally {
      activeRequests--;

      if (activeRequests == 0) {
        fp.dismissAlert(key: keyLoading);
      }
    }

    if (generalResponse.result) {
      GlobalHelper.logger.w(generalResponse.result);
      if (showLoading) {
        fp.dismissAlert(key: keyLoading);
      }
    } else {
      fp.dismissAlert(key: keyLoading);
        fp.showAlert(
          key: keyError,
          content: AlertGeneric(
            content: ErrorGeneric(
              keyToClose: keyError,
              message: generalResponse.message,
              messageButton: messageButton,
              onPress: onPress,
            ),
          ),
        );

    }
    return generalResponse;
  }

  HttpClient getHttpClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  Future<List<http.MultipartFile>> cloneMultipartFiles(List<http.MultipartFile> files) async {
    List<http.MultipartFile> cloned = [];

    for (var file in files) {
      try {
        final stream = file.finalize();
        final bytes = await stream.fold<List<int>>([], (prev, element) => prev..addAll(element));

        final newFile = http.MultipartFile.fromBytes(
          file.field,
          bytes,
          filename: file.filename,
          contentType: file.contentType,
        );

        cloned.add(newFile);
      } catch (e) {
        GlobalHelper.logger.w('Error clonando archivo: $e');
      }
    }

    return cloned;
}

}



class QaEnv extends BaseConfig {
  @override
  String get appName => 'Viadoc App';

  @override
  String get serviceUrl => 'https://api.viadoc.com.ec/api';

  @override
  String get serviceFileUrl =>
      'https://api.viadoc.com.ec/api/file/715d5309-2d27-46bd-bfb6-9c35ef0966d5?isForDownload=true';
}


Future<GeneralResponse<Uint8List>> getFileName(
  BuildContext context, {
  bool showLoading = true,
  required String token,  // este es el appFileTrace o originalFileTrace
}) async {
  final String url =
      '${Environment().config?.serviceUrl}/file/$token?isForDownload=true';

  try {
    // Obtener el token de sesión
    LoginResponse? userData = await SecurityStorage().getUserData();
    final tokenSesion = userData?.token ?? '';

    final resp = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $tokenSesion',
        'Accept': 'application/pdf',
      },
    );
    // resto igual...