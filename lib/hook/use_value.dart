import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

T useValue<T>({
  T Function(BuildContext) create,
  void Function(BuildContext, T) dispose,
}) {
  final value = useMemoized(() => create(useContext()), []);

  useEffect(() => () => dispose(useContext(), value), []);

  return value;
}
