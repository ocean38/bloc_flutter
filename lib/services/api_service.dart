import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:impacteer/base_bloc/bloc_event.dart';
import 'package:impacteer/base_bloc/bloc_response.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';
import 'package:impacteer/services/api_keys.dart';
import 'package:impacteer/services/rest_client.dart';

class ApiServices extends RestClient {
  static ApiServices? _apiServices;

  ApiServices._internal();

  factory ApiServices() {
    _apiServices ??= ApiServices._internal();
    return _apiServices ?? ApiServices._internal();
  }

  /// common interface for all api requests
  Future<BlocResponse> apiRequest(
    ApiRequestType request,
    BlocEvent event,
    String apiEndPoint, {
    Map<String, dynamic>? body,
    bool authHeader = false,
    bool isCsv = false,
    Map<String, String>? headers,
    ApiContentType contentType = ApiContentType.json,
    Map<String, dynamic>? queryParams,
    Duration? timeoutDuration,
  }) async {
    Uri uri = createURL(
      request,
      ApiEndPoints.baseUrl + apiEndPoint,
      queryParams,
    );

    await getHeaders(authHeader, contentType);

    // try api requests
    try {
      int statusCode;
      String responseBody;

      // multipart form-data request
      if (contentType == ApiContentType.formData) {
        http.StreamedResponse response = await formDataRequest(
          uri,
          request,
          headers ?? {},
          body!,
        );
        statusCode = response.statusCode;
        if (await response.stream.isEmpty == true) {
          responseBody = '{}';
        } else {
          List<String> dataList = await Future.wait(
            await response.stream
                .map((bytes) async =>
                    await http.ByteStream.fromBytes(bytes).bytesToString())
                .toList(),
          );
          responseBody = '';
          for (String data in dataList) {
            responseBody += data;
          }
        }
      } else {
        http.Response response;
        switch (request) {
          case ApiRequestType.apiGet:
            response = await getRequest(uri, headers ?? {});
            break;
          case ApiRequestType.apiPost:
            response = await postRequest(uri, headers ?? {}, body ?? {},
                timeoutDuration: timeoutDuration ?? const Duration(seconds: 4));
            break;
          case ApiRequestType.apiDelete:
            response = await deleteRequest(uri, headers ?? {}, body ?? {});
            break;
          case ApiRequestType.apiPatch:
            response = await patchRequest(uri, headers ?? {}, body ?? {});
            break;
          default:
            return BlocResponse(
              state: BlocState.failed,
              event: event,
              message: 'Unknown API request received: $request',
            );
        }
        statusCode = response.statusCode;
        responseBody = String.fromCharCodes(response.bodyBytes);
      }

      var res = isCsv ? responseBody : jsonDecode(responseBody);
      bool isSuccess = false;
      if (res is Map) {
        if ((res[ApiKeys.errorNo] == null || res[ApiKeys.errorNo] == 0)) {
          if (RegExpRule.successCode.hasMatch('$statusCode')) {
            isSuccess = true;
          }
        }
      } else {
        if (RegExpRule.successCode.hasMatch('$statusCode')) {
          isSuccess = true;
        }
      }

      if (isSuccess) {
        return BlocResponse(
          state: BlocState.success,
          event: event,
          data: res,
          statusCode: statusCode,
        );
      } else {
        return BlocResponse(
          state: BlocState.failed,
          event: event,
          message: res is String ? res : res[ApiKeys.message],
          data: res,
          statusCode: statusCode,
        );
      }
    } on SocketException {
      debugPrint("SocketException");
      return BlocResponse(
        state: BlocState.noInternet,
        event: event,
        message: 'NoInternet',
      );
    } on TimeoutException {
      debugPrint("TimeoutException");
      return BlocResponse(
        state: BlocState.noInternet,
        event: event,
        message: 'API Timeout',
      );
    } catch (e) {
      debugPrint("catch $e");
      return BlocResponse(
        state: BlocState.failed,
        event: event,
        message: e.toString(),
        exceptionType: e.runtimeType,
      );
    } finally {}
  }
}

///
class RegExpRule {
  static final RegExp successCode = RegExp(r'20\d');
}
