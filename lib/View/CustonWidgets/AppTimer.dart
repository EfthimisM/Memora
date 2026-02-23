import 'dart:async';

class AppTimer {
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isRunning = false;
  final void Function(String)? onTick;

  AppTimer({this.onTick});

  void start() {
    if (_isRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      onTick?.call(toString());
    });
    _isRunning = true;
    onTick?.call(toString()); // Immediate update
  }

  void pause() {
    _timer?.cancel();
    _isRunning = false;
    onTick?.call(toString()); // Update when paused
  }

  void restart() {
    _timer?.cancel();
    _secondsElapsed = 0;
    _isRunning = false;
    onTick?.call(toString()); // Update when reset
    start();
  }

  void dispose() {
    _timer?.cancel();
  }

  bool get isRunning => _isRunning;

  @override
  String toString() {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}