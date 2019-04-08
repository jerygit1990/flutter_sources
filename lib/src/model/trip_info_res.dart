import 'package:fl_uberapp/src/model/step_res.dart';

class TripInfoRes {
  final int distance; // in met
  final List<Steps> steps;

  TripInfoRes(this.distance, this.steps);
}
