import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player',
      theme: ThemeData.dark(),
      home: const VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() =>
      _VideoPlayerScreenState();
}

class _VideoPlayerScreenState
    extends State<VideoPlayerScreen> {

  final TextEditingController urlController =
      TextEditingController();

  VideoPlayerController? controller;

  Future<void> loadVideo() async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = VideoPlayerController.networkUrl(
      Uri.parse(urlController.text),
    );

    await controller!.initialize();

    controller!.play();

    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مشغل الفيديو"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                hintText: "ضع رابط الفيديو هنا",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: loadVideo,
              child: const Text("تشغيل"),
            ),

            const SizedBox(height: 20),

            if (controller != null &&
                controller!.value.isInitialized)

              AspectRatio(
                aspectRatio:
                    controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
              ),
          ],
        ),
      ),
    );
  }
}
