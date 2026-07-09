import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/models/post_model.dart';

class VideoPostWidget extends StatefulWidget {
  final String videoPath;
  final PostModel post;
  const VideoPostWidget({super.key, required this.videoPath, required this.post});

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_controller.value.isInitialized)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          )
        else
          const Center(child: CircularProgressIndicator(color: Color(0xFF8FD6B3))),
        // Overlay removed as requested for the Rocket page
      ],
    );
  }
}
