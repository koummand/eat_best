import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagePreview extends StatefulWidget{
ImagePreview(this.file, {super.key});
XFile file;
@override
State<ImagePreview> createState()=> _imagePreviewState();
}

class _imagePreviewState extends State<ImagePreview>{
  @override
  Widget build(BuildContext context){
    File picture= File(widget.file.path);
    return Scaffold(
      appBar:AppBar(title:Text("Image preview")),
      body:Center(
         child:Image.file(picture),
      )
    ); 
  }

}
