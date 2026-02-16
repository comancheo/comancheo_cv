import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String? title;
  final List<Widget>? content;

  const CustomDialog({super.key, required this.title, required this.content});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16).copyWith(right: 10, top: 15),
            child: Row(
              
              children: [
                if (widget.title != null) Expanded(child:Text(widget.title!, style: Theme.of(context).textTheme.headlineSmall, maxLines: 10,),),
                SizedBox(
                  height: 20,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.close),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10).copyWith(top: 0, bottom: 25),
              child: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [...?widget.content]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
