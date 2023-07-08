import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:impacteer/base_bloc/bloc_states.dart';

class BlocBuilderNew<T extends StateStreamable<BlocEventState>>
    extends StatefulWidget {
  //widgets for different state
  final Widget Function(BlocEventState) defaultView;
  final Widget Function(BlocEventState)? loadingView;
  final Widget Function(BlocEventState)? noInternetView;
  final Widget Function(BlocEventState)? successView;
  final Widget Function(BlocEventState)? failedView;

  /// callback function (UI) for different provider state
  final Function()? onInit;
  final Function()? onDispose;
  //callbacks for different state
  final Function(BlocEventState)? onSuccess;
  final Function(BlocEventState)? onFailed;
  final Function(BlocEventState)? onNoInternet;
  final Function(BlocEventState)? onLoading;

  const BlocBuilderNew({
    super.key,
    this.onInit,
    this.onDispose,
    required this.defaultView,
    this.loadingView,
    this.noInternetView,
    this.successView,
    this.failedView,
    this.onFailed,
    this.onSuccess,
    this.onLoading,
    this.onNoInternet,
  });

  @override
  State<BlocBuilderNew<T>> createState() => _BlocBuilderNewState<T>();
}

class _BlocBuilderNewState<T extends StateStreamable<BlocEventState>>
    extends State<BlocBuilderNew<T>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (widget.onInit != null) widget.onInit!(); // UI callback
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (widget.onDispose != null) widget.onDispose!(); // UI callback
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, BlocEventState>(
      builder: (context, state) {
        switch (state.state) {
          case BlocState.loading:
            return (widget.loadingView == null)
                ? widget.defaultView(state)
                : widget.loadingView!(state);
          case BlocState.noInternet:
            return (widget.noInternetView == null)
                ? widget.defaultView(state)
                : widget.noInternetView!(state);
          case BlocState.success:
            return (widget.successView == null)
                ? widget.defaultView(state)
                : widget.successView!(state);
          case BlocState.failed:
            return (widget.failedView == null)
                ? widget.defaultView(state)
                : widget.failedView!(state);
          default:
            return widget.defaultView(state);
        }
      },
      listener: (context, state) {
        _callback(state);
      },
    );
  }

  Future<void> _callback(BlocEventState state) async {
    if (state.state == state.response?.prevState &&
        state.event == state.response?.prevEvent) {
      return;
    }
    switch (state.state) {
      case BlocState.failed:
        if (widget.onFailed != null) widget.onFailed!(state);
        break;
      case BlocState.success:
        if (widget.onSuccess != null) widget.onSuccess!(state);
        break;
      case BlocState.loading:
        if (widget.onLoading != null) widget.onLoading!(state);
        break;
      case BlocState.noInternet:
        if (widget.onNoInternet != null) widget.onNoInternet!(state);
        break;
      default:
    }
  }
}
