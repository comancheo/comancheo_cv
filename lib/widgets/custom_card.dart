import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  const CustomCard({super.key, required this.child, this.color, this.padding, this.width, this.height, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child:Card(
      color: color ?? Theme.of(context).colorScheme.primaryContainer.withAlpha(128),
      child:Container(padding: padding ?? const EdgeInsets.all(20), width: width ?? double.infinity, height: height,child:child)));
  }
}