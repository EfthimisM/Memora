import 'package:audioplayers/audioplayers.dart';

class AudioService {
  Future<void> playDing() async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('sounds/ding.mp3'));
      player.onPlayerComplete.listen((event) {
        player.dispose();
      });
    } catch (e) {
      print('Failed to play sound: $e');
    }
  }
}