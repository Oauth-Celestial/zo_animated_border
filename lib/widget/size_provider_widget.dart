import 'package:flutter/material.dart';

class SizeProviderWidget extends StatefulWidget {
  final Widget Function(BuildContext context, Size size) builder;

  const SizeProviderWidget({super.key, required this.builder});

  @override
  SizeProviderWidgetState createState() => SizeProviderWidgetState();
}

class SizeProviderWidgetState extends State<SizeProviderWidget> {
  final GlobalKey _key = GlobalKey();
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSize());
  }

  void _updateSize() {
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    setState(() {
      _size = renderBox.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.builder(context, _size),
    );
  }
}
