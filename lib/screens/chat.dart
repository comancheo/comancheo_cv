import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Chat",
      body: [
        ...List.generate(100, (index) => CustomCard(child:Text("Item $index"))),
      ]
    );
  }
}