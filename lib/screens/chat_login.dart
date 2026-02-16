import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/chat.dart';
import 'package:comancheo_cv/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ChatLoginScreen extends StatefulWidget {
  const ChatLoginScreen({super.key});

  @override
  State<ChatLoginScreen> createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  ChatService chatService = GetIt.instance.get<ChatService>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NullStringCubit, String?>(bloc: chatService.token, listener: (context, state) {
          setState(() {});}),
        BlocListener<BoolCubit, bool>(bloc: chatService.verified, listener: (context, state) {
          setState(() {});}),
      ],
      child: CustomScaffold(
        title: "Chat registrace",
        body: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (chatService.token.state == null) ...[
                  TextField(
                    controller: chatService.emailController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]'))],
                    decoration: InputDecoration(
                      hintText: "Zadejte svůj email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await chatService.createUser();
                    },
                    child: Text("Registrovat"),
                  ),
                ],
                if (chatService.token.state != null) ...[
                  ///Verify email part
                  const SizedBox(height: 32),
                  TextField(
                    controller: chatService.codeFromEmailController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    decoration: InputDecoration(
                      hintText: "Zadejte kód z emailu",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await chatService.verifyEmail();
                    },
                    child: Text("Ověřit email"),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
