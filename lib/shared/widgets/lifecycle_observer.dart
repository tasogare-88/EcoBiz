import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/steps/presentation/steps_view_model.dart';

class LifecycleObserver extends ConsumerStatefulWidget {
  final Widget child;
  final String userId;

  const LifecycleObserver({
    super.key,
    required this.child,
    required this.userId,
  });

  @override
  ConsumerState<LifecycleObserver> createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends ConsumerState<LifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      ref
          .read(stepsViewModelProvider.notifier)
          .updateOnBackground(widget.userId);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
