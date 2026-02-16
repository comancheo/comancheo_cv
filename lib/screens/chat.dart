import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/models/chat_message.dart';
import 'package:comancheo_cv/services/chat.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:comancheo_cv/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatService chatService = GetIt.instance.get<ChatService>();

  @override
  void initState() {
    super.initState();
    chatService.receiveMessages();
  }

  @override
  void activate() {
    super.activate();
    chatService.receiveMessages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCubit<ChatMessage>, List<ChatMessage>>(
      bloc: chatService.messages,
      builder: (context, loading) {
        return CustomScaffold(
          title: "Chat",
          reverseListView: true,
          onRefresh: () async {
            await chatService.receiveMessages();
          },
          fixedFooterButtons: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatService.messageController,
                    decoration: InputDecoration(
                      hintText: "Napište zprávu",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await chatService.sendMessage(chatService.messageController.text);
                    chatService.messageController.clear();
                  },
                  child: Text("Odeslat"),
                ),
              ],
            ),
          ],
          body: [
            const SizedBox(height: 20),
            ...List.generate(chatService.messages.state.length, (index) {
              final message = chatService.messages.state[index];
              return MessageCard(
                meEmail: chatService.email ?? "",
                email: message.email,
                body: message.body,
                timestamp: message.timestamp,
              );
            }),
          ],
        );
      },
    );
  }
}
