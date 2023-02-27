import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string</title>
</head>
<body>

<h1>THIS IS A HTML STRING</h1>

</body>
</html>
''';

enum _MenuOptions {
  navigationDelegate,
  userAgent,
  // ignore: unused_field
  javascriptChannel,
  listCookies,
  clearCookies,
  loadFlutterAsset,
  loadHtmlString,
}

class Menu extends StatefulWidget {
  const Menu({required this.controller, super.key});

  final WebViewController controller;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final cookieManager = WebViewCookieManager();
  Future<void> _onListCookies(WebViewController controller) async {
    final String cookies = await controller
        .runJavaScriptReturningResult('document.cookie') as String;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cookies.isNotEmpty ? cookies : 'There are no cookies.'),
      ),
    );
  }

  Future<void> _onClearCookies() async {
    final hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There were no cookies to clear.';
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _onLoadHtmlStringExample(
      WebViewController controller, BuildContext context) async {
    await controller.loadHtmlString(kExamplePage);
  }

  Future<void> _onLoadFlutterAssetExample(
      WebViewController controller, BuildContext context) async {
    await controller.loadFlutterAsset('index.html');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (value) async {
        switch (value) {
          case _MenuOptions.navigationDelegate:
            await widget.controller.loadRequest(Uri.parse('https://vecka.nu'));
            break;
          case _MenuOptions.userAgent:
            final userAgent = await widget.controller
                .runJavaScriptReturningResult('navigator.userAgent');
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('$userAgent'),
            ));
            break;
          case _MenuOptions.listCookies:
            await _onListCookies(widget.controller);
            break;
          case _MenuOptions.clearCookies:
            await _onClearCookies();
            break;
          case _MenuOptions.loadFlutterAsset:
            await _onLoadFlutterAssetExample(widget.controller, context);
            break;
          case _MenuOptions.loadHtmlString:
            await _onLoadHtmlStringExample(widget.controller, context);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text('Kolla vecka'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.userAgent,
          child: Text('Show user-agent'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.listCookies,
          child: Text('Show cookies'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.loadFlutterAsset,
          child: Text('Load HTML FILE'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.loadHtmlString,
          child: Text('Load HTML string'),
        ),
      ],
    );
  }
}
