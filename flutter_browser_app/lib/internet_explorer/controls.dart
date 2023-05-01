import 'package:flutter/material.dart';

class IEGoBackControl extends StatelessWidget {
  final VoidCallback? onTap;

  const IEGoBackControl({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      autofocus: true,
      onPressed: onTap,
      icon: const Icon(Icons.arrow_circle_left_outlined),
    );
  }
}

class IEGoForwardControl extends StatelessWidget {
  final VoidCallback? onTap;

  const IEGoForwardControl({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.arrow_circle_right_outlined),
    );
  }
}

class IEReloadControl extends StatelessWidget {
  final VoidCallback? onTap;

  const IEReloadControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.refresh_outlined),
    );
  }
}
