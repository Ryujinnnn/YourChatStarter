import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageURL;
  const ImageDialog(this.imageURL, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String base64String = imageURL.replaceAll("data:image/png;base64,", "");
    return Dialog(
      child: Container(child: imageFromBase64String(base64String)),
    );
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}
