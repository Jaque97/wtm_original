import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RectImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  RectImage({this.imageUrl = "", this.width = 72.0, this.height = 92});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x4cd3d1d8),
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Color(0x4cd3d1d8),
                blurRadius: 6,
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/image-loader.gif"))),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x4cd3d1d8),
                blurRadius: 6,
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/logo.png"))),
      ),
    );
  }
}
