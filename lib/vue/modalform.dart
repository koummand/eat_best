import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ModalWidget extends StatelessWidget {
  File? image;
  ValueChanged<ImageSource>? onclicked;

  ModalWidget({Key? key, required this.image, required this.onclicked})
      : super(key: key);

  @override
  build(BuildContext context) {
    // final color = Theme.of(context).colorScheme.primary;
    return Center(
        child: Stack(
      children: [
        buildImage(context),
        // Positioned(bottom: 0, right: 4, child: buildEditIcon(color)),
      ],
    ));
  }

  Widget buildImage(BuildContext context) {
    final imagePath = this.image!.path;
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));
    return ClipOval(
      child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image as ImageProvider,
            fit: BoxFit.cover,
            height: 160,
            width: 160,
            child: InkWell(
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;
                onclicked!(source);
              },
            ),
          )),
    );
  }

  // Widget buildEditIcon(Color color) => buildCircle(color);

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      child: const Text('Gallry'),
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.gallery)),
                  CupertinoActionSheetAction(
                      child: const Text('Camera'),
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.camera))
                ],
              ));
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.image_outlined),
                    title: const Text('Gallery'),
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  )
                ],
              ));
    }
  }
}
