import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPage extends StatefulWidget {
  final String videoUrl;

  const TrailerPage({super.key, required this.videoUrl});

  @override
  State<TrailerPage> createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> with WidgetsBindingObserver {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Set landscape orientation
    _setLandscapeMode();

    // Extract video ID from URL
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          forceHD: true,
          enableCaption: true,
        ),
      );

      // Listen for video end event
      _controller.addListener(() {
        if (_controller.value.playerState == PlayerState.ended) {
          _exitPlayer();
        }
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes to ensure proper UI state
    if (state == AppLifecycleState.resumed) {
      _setLandscapeMode();
    }
  }

  void _setLandscapeMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _resetOrientation() async {
    await SystemChrome.setPreferredOrientations([]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void _exitPlayer() async {
    // Important: First pause the video
    _controller.pause();

    // Next, reset the orientation without awaiting
    _resetOrientation();

    // Important: Ensure we're still mounted before popping
    if (!mounted) return;

    // Pop with a small delay to ensure UI has updated
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!mounted) return;
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();

    // Reset orientation on disposal as a fallback
    _resetOrientation();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _exitPlayer();
        }
      },
      child: MediaQuery(
        // Remove bottom padding to prevent overflow
        data: MediaQuery.of(context).copyWith(
          padding: EdgeInsets.zero,
          viewPadding: EdgeInsets.zero,
          viewInsets: EdgeInsets.zero,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              // YouTube Player
              Center(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.red,
                    handleColor: Colors.redAccent,
                  ),
                  onReady: () {},
                  onEnded: (_) {
                    _exitPlayer();
                  },
                ),
              ),

              // Close button overlay
              Positioned(
                top: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: _exitPlayer,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
