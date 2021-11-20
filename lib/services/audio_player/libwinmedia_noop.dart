import 'dart:async';

class LWM {
  static initialize() {}
}

class Player {
  Player({int id});

  _PlayerState state = _PlayerState();
  _PlayerStreams streams = _PlayerStreams();

  void dispose() {}
  void open(List<Media> medias) {}
  void play() {}
  void pause() {}
  void seek(Duration duration) {}
}

class Media {
  Media({String uri, dynamic extras});
}

class _PlayerState {
  List<Media> medias = [];
  bool isPlaying = false;
  bool isBuffering = false;
  bool isCompleted = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  int index = 0;
}

class _PlayerStreams {
  Stream<List<Media>> medias;
  Stream<bool> isPlaying;
  Stream<bool> isBuffering;
  Stream<bool> isCompleted;
  Stream<Duration> position;
  Stream<Duration> duration;
  Stream<int> index;

  void dispose() {
    mediasController.close();
    isPlayingController.close();
    isBufferingController.close();
    isCompletedController.close();
    positionController.close();
    durationController.close();
    indexController.close();
  }

  _PlayerStreams() {
    medias = mediasController.stream;
    isPlaying = isPlayingController.stream;
    isBuffering = isBufferingController.stream;
    isCompleted = isCompletedController.stream;
    position = positionController.stream;
    duration = durationController.stream;
    index = indexController.stream;
  }

  final StreamController<List<Media>> mediasController =
      StreamController.broadcast();
  final StreamController<bool> isPlayingController =
      StreamController.broadcast();
  final StreamController<bool> isBufferingController =
      StreamController.broadcast();
  final StreamController<bool> isCompletedController =
      StreamController.broadcast();
  final StreamController<Duration> positionController =
      StreamController.broadcast();
  final StreamController<Duration> durationController =
      StreamController.broadcast();
  final StreamController<int> indexController = StreamController.broadcast();
}
