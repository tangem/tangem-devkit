import 'dart:async';

class Timers {
  static StreamSubscription countDown(Duration duration, Function(Duration?) tick, Function(bool) isFinished) {
    isFinished(false);
    final oneSecDuration = Duration(seconds: 1);
    Stream<Duration> stream = Stream.periodic(oneSecDuration, (_) => duration = duration - oneSecDuration);
    StreamSubscription subscription = stream.take(duration.inSeconds + 1).listen((duration) {
      if (duration == null || duration.inSeconds < 0) {
        isFinished(true);
        return;
      }

      tick(duration);
      if (duration.inSeconds == 0) {
        tick(null);
        isFinished(true);
      }
    });
    return subscription;
  }
}
