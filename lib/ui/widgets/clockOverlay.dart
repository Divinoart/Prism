import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ClockOverlay extends StatefulWidget {
  final String link;
  final bool file;
  final Color accent;
  final bool colorChanged;
  ClockOverlay({
    @required this.link,
    @required this.file,
    @required this.accent,
    @required this.colorChanged,
  });
  @override
  _ClockOverlayState createState() => _ClockOverlayState();
}

class _ClockOverlayState extends State<ClockOverlay> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now().toString();
    var hour = DateTime.now().hour.toString();
    return Material(
      child: Stack(
        children: <Widget>[
          !widget.file
              ? CachedNetworkImage(
                  imageUrl: widget.link,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: widget.colorChanged
                            ? ColorFilter.mode(widget.accent, BlendMode.hue)
                            : null,
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    File(widget.link),
                    color: widget.accent,
                    colorBlendMode:
                        widget.colorChanged ? BlendMode.color : null,
                    fit: BoxFit.cover,
                  ),
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                hour + date.substring(13, 16),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontSize: 80,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/dialer.png",
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                  Image.asset(
                    "assets/images/messages.png",
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                  Image.asset(
                    "assets/images/playstore.png",
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                  Image.asset(
                    "assets/images/chrome.png",
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                  Image.asset(
                    "assets/images/camera.png",
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Text(""),
            ),
            onTap: () => {Navigator.pop(context)},
          )
        ],
      ),
    );
  }
}
