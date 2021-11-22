import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:io'
    show
        HttpException,
        HttpClient,
        HttpOverrides,
        SecurityContext,
        HttpSession,
        HttpHeaders,
        SecureSocket,
        X509Certificate,
        RedirectInfo,
        HttpStatus,
        HttpConnectionInfo,
        HttpClientResponse,
        HttpClientResponseCompressionState,
        RedirectException,
        gzip,
        HttpDate,
        ContentType,
        Cookie,
        HeaderValue,
        IOSink,
        HttpResponse,
        Socket,
        HttpClientRequest,
        ZLibEncoder,
        SocketException,
        TlsException,
        ConnectionTask,
        InternetAddressType,
        SocketOption,
        HttpClientCredentials,
        InternetAddress,
        HttpServer,
        SecureServerSocket,
        HttpRequest,
        ServerSocket,
        HandshakeException,
        HttpConnectionsInfo,
        RawSocketOption,
        HttpClientBasicCredentials,
        HttpClientDigestCredentials,
        Platform,
        IOException;
import 'dart:typed_data';
import 'dart:developer';

part 'crypto.dart';
part 'http_headers.dart';
part 'http_impl.dart';
part 'http_parser.dart';
part 'http_session.dart';
part 'socks.dart';

class SocksProxy {
  SocksProxy._();

  /// proxy -> "SOCKS5/SOCKS4/PROXY username:password@hots:port" or "DIRECT"
  static void initProxy(
      {String? proxy,
      Function(HttpClient)? onCreate,
      String Function(Uri)? findProxy}) {
    HttpOverrides.global =
        _ProxyOverrides(proxy: proxy, onCreate: onCreate, findProxy: findProxy);
  }

  /// proxy -> "SOCKS5/SOCKS4/PROXY username:password@hots:port" or "DIRECT"
  static void setProxy(String? proxy) {
    final overrides = HttpOverrides.current;
    if (overrides is _ProxyOverrides) {
      overrides.proxy = proxy;
    }
  }
}

HttpClient createProxyHttpClient({SecurityContext? context}) {
  return _HttpClient(context);
}

class _ProxyOverrides extends HttpOverrides {
  final Function(HttpClient)? onCreate;
  final String Function(Uri)? findProxy;

  /// proxy -> "SOCKS5/SOCKS4/PROXY username:password@hots:port;" or "DIRECT"
  String? proxy;

  _ProxyOverrides({this.onCreate, this.proxy, this.findProxy});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final httpClient = createProxyHttpClient(context: context);
    if (onCreate != null) onCreate!(httpClient);

    return httpClient
      ..findProxy = findProxy ??
          (url) {
            return proxy ?? 'DIRECT';
          };
  }
}
