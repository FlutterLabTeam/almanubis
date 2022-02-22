import 'package:flutter/material.dart';

draggableBottomPanel({
  required BuildContext context,
  required Function(String) handledTapItem,
  required Widget body,
}) {
  BorderRadius effectiveBorderRadius = const BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  );
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: effectiveBorderRadius,
    ),
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.76,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: ShapeDecoration(
            color: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: effectiveBorderRadius,
            ),
          ),
          child: body
        );
      },
    ),
    isScrollControlled: true,
  );
}
