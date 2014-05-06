library smartcanvas.test;

import 'dart:html' as dom;

import '../lib/smartcanvas.dart';
import './svg_tests/svg_tests.dart';
import './canvas_tests/canvas_tests.dart';

Stage stage;

void main() {
  dom.Element container = dom.document.querySelector('#canvas');

  stage = new Stage(container, svg, {
    WIDTH: container.clientWidth,
    HEIGHT: 900,
  });

  SvgTests.run();
}