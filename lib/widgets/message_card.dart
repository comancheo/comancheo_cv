import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String meEmail;
  final String email;
  final String? body;
  final DateTime timestamp;

  const MessageCard({super.key, required this.meEmail, required this.email, required this.body, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: meEmail == email ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        CustomCard(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Wrap(
            direction: Axis.vertical,
            spacing: 4,
            children: [
              Text(email, style: Theme.of(context).textTheme.bodySmall),
              if (body != null) Text(body!, textAlign: meEmail == email ? TextAlign.right : TextAlign.left, style: Theme.of(context).textTheme.bodyMedium),
              Text(timestamp.toString(), style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}
