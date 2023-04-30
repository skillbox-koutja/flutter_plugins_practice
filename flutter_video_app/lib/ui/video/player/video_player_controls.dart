import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_video_app/ui/video/player/video_player_slider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerControls({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  VideoPlayerControlsState createState() => VideoPlayerControlsState();
}

class VideoPlayerControlsState extends State<VideoPlayerControls> {
  late AnimationController _animationController;
  Timer? _hideControlsTimer;
  bool get isPlaying => widget.controller.value.isPlaying;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onVideoEnd);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.play();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onVideoEnd);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: _handleHover,
      onTapDown: (_) => _handleTap(),
      child: _AnimatedControls(
        onInit: (controller) {
          _animationController = controller;
          _hideControls();
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoPlayerSlider(controller: widget.controller),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _rewindVideo(-10),
                    icon: const Icon(
                      Icons.replay_10,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ValueListenableBuilder(
                    valueListenable: widget.controller,
                    builder: (_, state, __) {
                      return InkWell(
                        onTap: state.isPlaying ? _pause : _play,
                        child: Icon(
                          state.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _rewindVideo(10),
                    icon: const Icon(
                      Icons.forward_10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onVideoEnd() {
    if (!isPlaying) {
      _showControls();
    }
  }

  void _handleTap() {
    if (isPlaying) {
      _pause();
    } else {
      _play();
    }
  }

  void _handleHover(enteredPointer) {
    if (enteredPointer) {
      _showControls();
    } else {
      if (isPlaying) {
        _hideControls();
      }
    }
  }

  void _pause() {
    _showControls();
    widget.controller.pause();
  }

  void _play() {
    _hideControls();
    widget.controller.play();
  }

  void _hideControls() {
    if (_hideControlsTimer?.isActive ?? false) _hideControlsTimer?.cancel();

    _hideControlsTimer = Timer(const Duration(seconds: 2), () {
      _animationController.reverse();
    });
  }

  void _showControls() {
    if (_hideControlsTimer?.isActive ?? false) _hideControlsTimer?.cancel();

    _animationController.forward();
  }

  void _rewindVideo(int seconds) {
    widget.controller.seekTo(
      Duration(seconds: widget.controller.value.position.inSeconds + seconds),
    );
    _hideControls();
  }
}

class _AnimatedControls extends StatefulWidget {
  final void Function(AnimationController controller) onInit;
  final Widget child;

  const _AnimatedControls({
    super.key,
    required this.onInit,
    required this.child,
  });

  @override
  State<_AnimatedControls> createState() => _AnimatedControlsState();
}

class _AnimatedControlsState extends State<_AnimatedControls> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _backgroundOpacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _backgroundOpacity = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _offset = Tween<Offset>(
      end: Offset.zero,
      begin: const Offset(0.0, 1.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _controller.forward();

    widget.onInit(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (_, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(_backgroundOpacity.value),
          ),
          child: SlideTransition(
            position: _offset,
            child: Opacity(
              opacity: _opacity.value,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
