// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

class AssignIf {
  T notNull<T>({
    required value,
    required defaultTo,
  }) =>
      value ?? defaultTo;

  T resultNotNull<T>({
    required Function task,
    required resultTo,
  }) =>
      task() ?? resultTo;

  Future<T> resultNotNullAsync<T>({
    required Function task,
    required resultTo,
  }) async =>
      (await task()) ?? resultTo;
}

class RenderIf extends StatelessWidget {
  final bool isTrue;
  final Widget child;
  final Widget? elseRender;
  const RenderIf({
    Key? key,
    required this.isTrue,
    required this.child,
    this.elseRender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTrue) return child;
    return elseRender ?? const Offstage();
  }
}
