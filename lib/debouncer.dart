import 'dart:async';

class Debouncer {
  final int milliSec;
  late Function action;
  Timer? _timer;

  Debouncer({required this.milliSec});

  void debounce(Function action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSec), () {
      action();
    });
  }
}