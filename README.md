# flutter_socks_proxy

**flutter_socks_proxy** is a dart package, HTTP/Socks4/Socks5 proxy

## Flutter version scope

| flutter_socks_proxy  | Flutter |
| ------------- | ------------- |
| 0.0.1 | < 3.0 |
| 0.0.2 | >= 3.0 |

## Usage

### Use global 

```dart
import 'dart:convert';
import 'dart:io';
import 'package:socks_proxy/socks_proxy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // proxy -> "SOCKS5/SOCKS4/PROXY username:password@host:port;" or "DIRECT"
  SocksProxy.initProxy(proxy: 'SOCKS5 192.168.31.180:7891');
    await HttpClient()
        .getUrl(Uri.parse('https://raw.githubusercontent.com/tayoji-io/socks_proxy/master/README.md'))
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
  runApp(MyApp());
}
```

### Use independent
``` dart
import 'dart:convert';
import 'dart:io';
import 'package:socks_proxy/socks_proxy.dart';

 void requset() async {
  // proxy -> "SOCKS5/SOCKS4/PROXY username:password@host:port;" or "DIRECT"
  final http = createProxyHttpClient()
    ..findProxy = (url) => 'SOCKS5 192.168.31.180:7891';
  await http
      .getUrl(Uri.parse('https://raw.githubusercontent.com/tayoji-io/socks_proxy/master/README.md'))
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

```


