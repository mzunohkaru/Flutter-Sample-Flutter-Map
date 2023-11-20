import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Map',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyMap());
  }
}

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  var mapController = MapController();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
            initialCenter: LatLng(36, 140),
            initialZoom: 9.2,
            minZoom: 2,
            maxZoom: 14),
        children: [
          // Map
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          // Info Button
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                '''
                An animated, 
                interactive attribution layer that supports both logos/images (displayed permanently)
                ''',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
          // Marker
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(36, 140),
                width: 80,
                height: 80,
                child: FlutterLogo(),
              ),
            ],
          ),
          // ポリゴン
          PolylineLayer(
            polylines: [
              Polyline(
                points: [LatLng(36, 140), LatLng(36.5, 140.5), LatLng(38, 141)],
                color: Colors.blue,
              ),
            ],
          ),
          // サークル
          CircleLayer(
            circles: [
              CircleMarker(
                  point: LatLng(36, 140),
                  radius: 10000,
                  useRadiusInMeter: true,
                  color: Colors.green.withOpacity(0.3),
                  borderColor: Colors.black,
                  borderStrokeWidth: 1),
            ],
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                  point: LatLng(38, 141),
                  radius: 10000,
                  useRadiusInMeter: true,
                  color: Colors.red.withOpacity(0.3),
                  borderColor: Colors.black,
                  borderStrokeWidth: 1),
            ],
          ),
          // オーバーレイ画像
          // OverlayImageLayer(
          //   overlayImages: [
          //     OverlayImage(
          //       bounds: LatLngBounds(
          //         LatLng(36, 140),
          //         LatLng(38, 141),
          //       ),
          //       imageProvider: NetworkImage(
          //           'https://content.gitbook.com/content/6crWs9H40DxNQrzXYdrt/blobs/Pvgy4YVJydNXu0wuJPR7/ExampleImageOverlay.png'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
