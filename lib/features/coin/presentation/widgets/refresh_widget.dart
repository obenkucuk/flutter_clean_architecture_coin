import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverRefreshWidget extends StatelessWidget {
  final bool isRefreshing;
  final Future<void> Function() onRefresh;
  const SliverRefreshWidget({
    super.key,
    required this.onRefresh,
    required this.isRefreshing,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      refreshTriggerPullDistance: 100,
      refreshIndicatorExtent: 50,
      builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance, refreshIndicatorExtent) {
        return ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(50, 50)),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                bottom: 5,
              ),
              child: Center(
                child: pulledExtent < 100 && !isRefreshing
                    ? Icon(!isRefreshing ? Icons.arrow_downward_outlined : Icons.arrow_upward_outlined)
                    : const CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        );
      },
    );
  }
}
