import 'package:flutter/material.dart';

class MeasureHeight extends StatefulWidget {
  final Widget child;
  final Function(double height) onHeightChanged;

  const MeasureHeight({required this.child, required this.onHeightChanged, super.key});

  @override
  _MeasureHeightState createState() => _MeasureHeightState();
}

class _MeasureHeightState extends State<MeasureHeight> {
  final GlobalKey _key = GlobalKey();
  double _lastHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());
  }

  void _updateHeight() {
    if (!mounted) return;

    final context = _key.currentContext;
    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final double newHeight = renderBox.size.height;

      if (newHeight != _lastHeight) {
        setState(() {
          _lastHeight = newHeight;
        });
        print("ashhfshkdksdfhskhdfhs");
        print(newHeight);
        widget.onHeightChanged(newHeight);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,  // Key should be on the actual measuring widget
      child: widget.child,
    );
  }
}
