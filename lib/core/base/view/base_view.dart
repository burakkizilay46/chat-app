// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final T provider;
  final Function(T model) onProviderReady;
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Widget child;
  final Function(T model)? onDispose;

  const BaseView({
    Key? key,
    required this.provider,
    required this.onProviderReady,
    required this.builder,
    required this.child,
    this.onDispose,
  }) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  late T provider;
  @override
  void initState() {
    provider = widget.provider;
    widget.onProviderReady(provider);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.onDispose != null) widget.onDispose!(provider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: provider,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
