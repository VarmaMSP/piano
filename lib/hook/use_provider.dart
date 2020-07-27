// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

T useProvider<T>({
  @required T Function(BuildContext) create,
  @required void Function(BuildContext, T) dispose,
}) {
  final context = useContext();
  final value = useMemoized(() => create(context), []);

  useEffect(() => () => dispose(context, value), []);

  return value;
}
