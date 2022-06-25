import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../main.dart';

// ignore: must_be_immutable
class MapWidget extends StatefulWidget {
  double latitude;
  double longitude;
  CloseButtonClick onCloseButtonClick;
  MapWidget(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.onCloseButtonClick})
      : super(key: key);
  @override
  MapWidgetState createState() =>
      MapWidgetState(this.latitude, this.longitude, this.onCloseButtonClick);
}

typedef CloseButtonClick = void Function(bool isShowed);

class MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 300), vsync: this)
    ..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  double latitude;
  double longitude;
  final CloseButtonClick onCloseButtonClick;
  MapWidgetState(this.latitude, this.longitude, this.onCloseButtonClick);
  double startPos = 1.5;
  double endPos = 0;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: Offset(0, startPos), end: Offset(0, endPos))
              .animate(_animation),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: Column(
          children: [
            IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _controller.reverse();
                    Timer(Duration(milliseconds: 300), () {
                      onCloseButtonClick(false);
                    });
                  });
                }),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(latitude, longitude),
                  zoom: 14.0,
                ),
                children: <Widget>[
                  TileLayerWidget(
                      options: TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
