import 'package:flutter/material.dart';

import 'package:model_viewer_plus/model_viewer_plus.dart';

class My3d extends StatefulWidget {
  final String modelpath;

  const My3d({super.key, required this.modelpath});

  @override
  State<My3d> createState() => _My3dState();
}

class _My3dState extends State<My3d> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3D viewer')),
      body: ModelViewer(
        backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        src: widget.modelpath,
        alt: 'A 3D model of an astronaut',
        ar: true,
        autoPlay: true,
        autoRotate: false,
        disableZoom: true,
        cameraControls: true,
      ),
    );
  }
}
