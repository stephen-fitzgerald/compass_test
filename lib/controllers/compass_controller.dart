import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:compass_test/services/compass_service.dart';

class CompassController with ChangeNotifier {
  final CompassService _compassService = CompassService();
  StreamSubscription<CompassEvent>? _compassSubscription;
  double? compassHeading;
  String? compassDirection;

  CompassController() {
    _compassSubscription = _compassService.compassStream?.listen((event) {
      compassHeading = event.heading;
      compassDirection = _compassService.getDirection(event.heading ?? 0);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }
}
