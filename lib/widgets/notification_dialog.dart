import 'package:comancheo_cv/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final String? title;
  final String? body;

  const NotificationDialog({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      content: [
        Text(body ?? '', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
      ],
    );
  }
}
