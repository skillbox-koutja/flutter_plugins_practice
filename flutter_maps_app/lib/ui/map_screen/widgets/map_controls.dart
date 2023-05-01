import 'package:flutter/material.dart';

class MapControl extends StatelessWidget {
  final Widget child;

  const MapControl({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 0.05,
          ),
        ],
      ),
      child: child,
    );
  }
}

class ZoomInControl extends StatelessWidget {
  final VoidCallback onTap;

  const ZoomInControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class ZoomOutControl extends StatelessWidget {
  final VoidCallback onTap;

  const ZoomOutControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.remove),
      ),
    );
  }
}

class HomeControl extends StatelessWidget {
  final VoidCallback onTap;

  const HomeControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.home_outlined),
      ),
    );
  }
}

class MoveUpControl extends StatelessWidget {
  final VoidCallback onTap;

  const MoveUpControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.arrow_drop_up_outlined),
      ),
    );
  }
}

class MoveDownControl extends StatelessWidget {
  final VoidCallback onTap;

  const MoveDownControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.arrow_drop_down_outlined),
      ),
    );
  }
}

class MoveLeftControl extends StatelessWidget {
  final VoidCallback onTap;

  const MoveLeftControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.arrow_left_outlined),
      ),
    );
  }
}

class MoveRightControl extends StatelessWidget {
  final VoidCallback onTap;

  const MoveRightControl({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MapControl(
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.arrow_right_outlined),
      ),
    );
  }
}
