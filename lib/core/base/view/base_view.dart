// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final T provider;
  final Function(T model) onProviderReady;
  final Function(T value) onPageBuilder;
  final Function(T model)? onDispose;

  const BaseView({
    Key? key,
    required this.provider,
    required this.onProviderReady,
    required this.onPageBuilder,
    this.onDispose,
  }) : super(key: key);

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
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
    if (widget.onDispose != null) widget.onDispose!(provider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => widget.provider,
      child: widget.onPageBuilder(provider) as Widget,
    );
  }
}
