import 'dart:async';
import 'dart:html';

class Debouncer {
  
  final int millisecounds;

  Timer? _timer;

  Debouncer({required this.millisecounds});

  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: millisecounds), callback);
  }


}