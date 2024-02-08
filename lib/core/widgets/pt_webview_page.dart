import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:insuranceapp/core/entities/webview_params.dart';
import 'package:insuranceapp/core/utils/utils.dart';

class PTWebviewPagw extends StatelessWidget {
  final WebviewParams params;
  const PTWebviewPagw({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(params.label ?? Utils.getTranslate(context, params.name)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(params.url ?? '')),
        ),
      ),
    );
  }
}
