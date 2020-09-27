import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Creates a page route for use in an iOS designed app.
///
/// The [builder], [maintainState], and [fullscreenDialog] arguments must not
/// be null.
///
Route cupertinoRoute(widget) {
  return new CupertinoPageRoute(
    builder: (BuildContext context) => widget,
    settings: new RouteSettings(
      name: widget.toStringShort(),
    ),
  );
}

/// Construct a MaterialPageRoute whose contents are defined by [builder].
///
/// The values of [builder], [maintainState], and [fullScreenDialog] must not
/// be null.
///
Route materialRoute(widget) {
  return new MaterialPageRoute(
    builder: (BuildContext context) => widget,
    settings: new RouteSettings(
      name: widget.toStringShort(),
    ),
  );
}
