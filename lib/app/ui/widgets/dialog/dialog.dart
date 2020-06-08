import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBody extends StatelessWidget {
  final Widget child;

  const DialogBody({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.all(24),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: Material(
              color: Theme.of(context).dialogBackgroundColor,
              elevation: 24,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
              type: MaterialType.card,
              clipBehavior: Clip.none,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class DialogTitle extends StatelessWidget {
  final String title;

  const DialogTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.headline6,
        child: Semantics(
          child: TextWidget(title),
          namesRoute: true,
          container: true,
        ),
      ),
    );
  }
}
