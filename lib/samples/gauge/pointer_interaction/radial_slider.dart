/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports
import '../../../model/sample_view.dart';

/// Renders the gauge with pointer dragging
class RadialSliderExample extends SampleView {
  /// Creates the gauge with pointer dragging
  const RadialSliderExample(Key key) : super(key: key);

  @override
  _RadialSliderExampleState createState() => _RadialSliderExampleState();
}

class _RadialSliderExampleState extends SampleViewState {
  _RadialSliderExampleState();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      _firstMarkerSize = 10;
      _annotationFontSize = 25;
      if (model.isWeb) {
        _width = _width * 0.35;
      }
    } else {
      _firstMarkerSize = model.isWeb ? 10 : 5;
      _annotationFontSize = model.isWeb ? 25 : 15;
      _width = _width * 0.35;
    }

    return Scaffold(
        backgroundColor:
            model.isWeb ? Colors.transparent : model.cardThemeColor,

        /// Added separate view for sample browser tile view and expanded view.
        /// In tile view, slider widget is removed.
        body: isCardView
            ? getRadialSliderExample(true)
            : Padding(
                padding: model.isWeb
                    ? const EdgeInsets.fromLTRB(5, 20, 5, 20)
                    : const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 7, // takes 70% of available height
                      child: SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                            axisLineStyle: AxisLineStyle(
                                thickness: 0.2,
                                thicknessUnit: GaugeSizeUnit.factor),
                            showTicks: false,
                            showLabels: true,
                            onAxisTapped: handlePointerValueChanged,
                            pointers: <GaugePointer>[
                              RangePointer(
                                  value: _currentValue,
                                  onValueChanged: handlePointerValueChanged,
                                  onValueChangeEnd: handlePointerValueChanged,
                                  onValueChanging: handlePointerValueChanging,
                                  enableDragging: true,
                                  width: 0.2,
                                  sizeUnit: GaugeSizeUnit.factor),
                              MarkerPointer(
                                value: _markerValue,
                                color: Colors.white,
                                markerHeight: _firstMarkerSize,
                                markerWidth: _firstMarkerSize,
                                markerType: MarkerType.circle,
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        '$_annotationValue',
                                        style: TextStyle(
                                            fontSize: _annotationFontSize,
                                            fontFamily: 'Times',
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF00A8B5)),
                                      ),
                                      Text(
                                        ' %',
                                        style: TextStyle(
                                            fontSize: _annotationFontSize,
                                            fontFamily: 'Times',
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF00A8B5)),
                                      )
                                    ],
                                  ),
                                  positionFactor: 0.13,
                                  angle: 0)
                            ])
                      ]),
                    ),
                    Expanded(
                        flex: model.isWeb ? 2 : 3,
                        child: Container(
                          width: _width,
                          child: Slider(
                            activeColor: const Color(0xFF02AAB0),
                            inactiveColor: const Color(0xFF00CDAC),
                            min: 5,
                            max: 100,
                            onChanged: handlePointerValueChanged,
                            value: _currentValue,
                          ),
                        )),
                  ],
                )));
  }

  /// Dragged pointer new value is updated to pointer and
  /// annotation current value.
  void handlePointerValueChanged(double value) {
    if (value.toInt() > 6) {
      setState(() {
        _currentValue = value.roundToDouble();
        final int _value = _currentValue.toInt();
        _annotationValue = '$_value';
        _markerValue = _currentValue - 2;
      });
    }
  }

  /// Pointer dragging is canceled when dragging pointer value is less than 6.
  void handlePointerValueChanging(ValueChangingArgs args) {
    if (args.value.toInt() <= 6) {
      args.cancel = true;
    }
  }

  /// Returns the radial slider gauge
  Widget getRadialSliderExample(bool isTileView) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          axisLineStyle: AxisLineStyle(
              thickness: 0.2, thicknessUnit: GaugeSizeUnit.factor),
          showTicks: false,
          showLabels: false,
          radiusFactor: 1,
          pointers: <GaugePointer>[
            RangePointer(value: 60, width: 0.2, sizeUnit: GaugeSizeUnit.factor),
            MarkerPointer(
              value: 58,
              color: Colors.white,
              markerHeight: 5,
              markerWidth: 5,
              markerType: MarkerType.circle,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      '60',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A8B5)),
                    ),
                    Text(
                      ' %',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00A8B5)),
                    )
                  ],
                ),
                positionFactor: 0.13,
                angle: 0)
          ])
    ]);
  }

  double _currentValue = 60;
  double _markerValue = 58;
  double _firstMarkerSize = 10;
  double _annotationFontSize = 25;
  String _annotationValue = '60';
}
