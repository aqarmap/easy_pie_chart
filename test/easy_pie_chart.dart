import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:easy_pie_chart/utils/pie_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<PieData> pies = [
    PieData(value: 0.45, color: Colors.yellow),
    PieData(value: 0.35, color: Colors.cyan),
    PieData(value: 0.2, color: Colors.deepOrange),
  ];

  test("get pie values without gap",
      () => expect(Utils.getValues(pies, 0.0), [0.45, 0.35, 0.2]));
  test(
      "get pie values with gap",
      () => expect(
          Utils.getValues(pies, 0.03), [0.45, 0.03, 0.35, 0.03, 0.2, 0.03]));

  test('convert -ve angle to positive in range(0,360)', () {
    expect(Utils.getPositiveAngle(-22.0), 338.0);
    expect(Utils.getPositiveAngle(22.0), 22.0);
  });

  test('convert start angle in between 0 to 360', () {
    expect(Utils.getAngleIn360(-90.0), 270.0);
    expect(Utils.getAngleIn360(-45.0), 315.0);
    expect(Utils.getAngleIn360(360), 0.0);
  });
  test('if tap angle in between start and sweep angle should return true',
      () => expect(Utils.isCurrentPieTap(270.0, 350.0, 320.0), true));
  test('if tap angle not in between start and sweep angle should return false',
      () => expect(Utils.isCurrentPieTap(270.0, 350.0, 0.0), false));

  test('getIndex on Pie Tapped with and without gap', () {
    expect(Utils.getIndexOfTappedPie([0.45, 0.35, 0.2], 1.0, 0.0, 270.0, 350.0),
        0);
    expect(
        Utils.getIndexOfTappedPie([0.45, 0.35, 0.2], 1.0, 0.0, 270.0, 90.0), 1);
    expect(
        Utils.getIndexOfTappedPie(
            [0.45, 0.03, 0.35, 0.03, 0.2, 0.03], 1.0, 0.03, 270.0, 60.0),
        0);
  });
}
