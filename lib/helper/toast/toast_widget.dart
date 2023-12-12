// Flutter imports:
import 'package:flutter/material.dart';

class ProxyInitState extends StatefulWidget {
  final Widget child;
  final VoidCallback initStateCallback;

  const ProxyInitState({
    super.key,
    required this.initStateCallback,
    required this.child,
  });

  @override
  ProxyInitStateState createState() => ProxyInitStateState();
}

class ProxyInitStateState extends State<ProxyInitState> {
  @override
  void initState() {
    widget.initStateCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ProxyDispose extends StatefulWidget {
  final Widget child;
  final VoidCallback disposeCallback;

  const ProxyDispose({
    super.key,
    required this.disposeCallback,
    required this.child,
  });

  @override
  ProxyDisposeState createState() => ProxyDisposeState();
}

class ProxyDisposeState extends State<ProxyDispose> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeCallback();
    super.dispose();
  }
}
