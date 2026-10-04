import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class HttpTestAdapter implements HttpClientAdapter {
  HttpTestAdapter(this.handle);

  final Future<ResponseBody> Function(RequestOptions) handle;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => handle(options);

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonResponse(Object? data, {int status = 200}) =>
    ResponseBody.fromString(
      jsonEncode(data),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
