import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:socks_proxy/socks_proxy.dart';

void main() {
  test('Global test', () async {
    SocksProxy.initProxy(proxy: 'SOCKS5 192.168.31.180:7891');
    await HttpClient()
        .getUrl(Uri.parse('https://www.google.com'))
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
    final http = createProxyHttpClient()
      ..findProxy = (url) => 'SOCKS5 192.168.31.180:7891';
    await http
        .getUrl(Uri.parse('https://www.google.com'))
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

void requset() async {
  final http = createProxyHttpClient()
    ..findProxy = (url) => 'SOCKS5 192.168.31.180:7891';
  await http
      .getUrl(Uri.parse('https://www.google.com'))
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
}
