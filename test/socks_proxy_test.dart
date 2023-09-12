import 'dart:convert';
import 'dart:io';

import 'package:flutter_socks_proxy/socks_proxy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Global test', () async {
    // proxy -> "SOCKS5/SOCKS4/PROXY username:password@host:port;" or "DIRECT"
    SocksProxy.initProxy(proxy: 'SOCKS5 192.168.31.180:8889');

    await HttpClient()
        .getUrl(Uri.parse('https://www.baidu.com'))
        .then((value) {
          return value.close();
        })
        .then((value) {
          return value.transform(utf8.decoder);
        })
        .then((value) {
          return value.fold(
              '', (dynamic previous, element) => previous + element);
        })
        .then((value) => print(value))
        .catchError((e) => print(e));
    // SocksProxy.setProxy('SOCKS4 192.168.31.180:7891');
  });

  test('Independent test', () async {
    // proxy -> "SOCKS5/SOCKS4/PROXY username:password@host:port;" or "DIRECT"
    final http = createProxyHttpClient()
      ..findProxy = (url) => 'SOCKS5 192.168.31.180:7891';
    await http
        .getUrl(Uri.parse(
            'https://raw.githubusercontent.com/tayoji-io/socks_proxy/master/README.md'))
        .then((value) {
          return value.close();
        })
        .then((value) {
          return value.transform(utf8.decoder);
        })
        .then((value) {
          return value.fold(
              '', (dynamic previous, element) => previous + element);
        })
        .then((value) => print(value))
        .catchError((e) => print(e));
  });
}
