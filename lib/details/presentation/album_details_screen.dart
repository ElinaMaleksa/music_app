import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AlbumDetailsScreen extends StatefulWidget {
  const AlbumDetailsScreen({Key? key, required this.albumUrl}) : super(key: key);

  final String? albumUrl;

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) => NavigationDecision.navigate))
      ..loadRequest(Uri.parse(widget.albumUrl ?? 'https://music.apple.com/us/browse/top-charts/albums/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
