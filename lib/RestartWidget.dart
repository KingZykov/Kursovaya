import 'package:flutter/cupertino.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});   // required - не было

  final Widget child;

  static void restartApp(BuildContext context) {
    // print(">>>" + "-----restartApp----");
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();   // ? - не было
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }


}