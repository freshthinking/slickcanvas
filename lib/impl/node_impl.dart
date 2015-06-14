part of smartcanvas;

abstract class NodeImpl {
  NodeImpl parent;
  final Node shell;

  NodeImpl(this.shell);

  CanvasType get type;

  void remove();

  LayerImpl get layer => shell.layer.impl;

  Stage get stage => shell.stage;

  void on(String events, Function handler, [String id]);

  void setAttribute(String attr, value, [bool removeIfNull = false]) =>
    shell.setAttribute(attr, value, removeIfNull);

  getAttribute(String attr, [defaultValue = null]) =>
    shell.getAttribute(attr, defaultValue);

  String get id => shell.id;

  num get width => shell.width;
  num get height => shell.height;

  void set fill(value) {
    shell.fill = value;
  }

  get fill => shell.fill;

  void set stroke(value) {
    shell.stroke = value;
  }

  get stroke => shell.stroke;

  void set strokeWidth(num value) {
    shell.strokeWidth = value;
  }

  num get strokeWidth => shell.strokeWidth;
}
