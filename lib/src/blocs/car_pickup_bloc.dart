import 'dart:async';

import 'package:fl_uberapp/src/configs/car_utils.dart';
import 'package:fl_uberapp/src/model/car_item.dart';

class CarPickupBloc {
  var _pickupController = StreamController();
  var carsList = CarUtils.getCarList();
  var currentSelected = 0;

  get stream => _pickupController.stream;

  void selectItem(int index) {
    currentSelected = index;
    _pickupController.sink.add(currentSelected);
  }

  CarItem getCurrentCar() {
    return carsList.elementAt(currentSelected);
  }

  bool isSelected(int index) {
    return index == currentSelected;
  }

  void dispose() {
    _pickupController.close();
  }
}
