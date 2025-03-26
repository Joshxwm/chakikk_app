import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreen extends StatefulWidget {
  final String mapType;

  const MapScreen({super.key, required this.mapType, required String mapId});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(_getMapUrl(widget.mapType)));
  }

  String _getMapUrl(String mapType) {
    const apiKey = "040cd95f-1794-497d-89de-882c737a98fc";
    return "https://atlas.microsoft.com/map/tile?subscription-key=$apiKey"
        "&api-version=2021-02-01&tilesetId=${_getTilesetId(mapType)}"
        "&zoom=5&x=1&y=1&tileSize=512";
  }

  String _getTilesetId(String mapType) {
    switch (mapType) {
      case 'satelital':
        return 'microsoft.imagery';
      case 'temperatura':
        return 'microsoft.weather.temperature';
      case 'viento':
        return 'microsoft.weather.wind';
      case 'precipitacion':
        return 'microsoft.weather.precipitation';
      default:
        return 'microsoft.base.road';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa: ${widget.mapType}")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
