part of smartcanvas.svg;

abstract class SvgGradient extends SvgNode {

  SvgGradient(Gradient shell): super(shell) {}

  SVG.SvgElement _createElement() {
    var el = __createElement();
    el.nodes.addAll(_getStopElements());
    return el;
  }

  SVG.SvgElement __createElement();

  Set<String> _getElementAttributeNames() {
    var rt = super._getElementAttributeNames();
    rt.addAll([X1, Y1, X2, Y2]);
    return rt;
  }

  List<SVG.StopElement> _getStopElements() {
    List<SVG.StopElement> stopElements = [];
    stops.forEach((stop) {
      SVG.StopElement stopEl = new SVG.StopElement();
      stopEl.setAttribute(OFFSET, getValue(stop, OFFSET, '0%'));
      var color = stop[COLOR];
      if (color != null) {
        stopEl.style.setProperty('stop-color', '$color');
      }
      var opacity = stop[OPACITY];
      if (opacity != null) {
        stopEl.style.setProperty('stop-opacity', '$opacity');
      }
      stopElements.add(stopEl);
    });
    return stopElements;
  }

  void set stops(List<Map<String, dynamic>> value) => setAttribute(STOPS, value);
  List<Map<String, dynamic>> get stops => getAttribute(STOPS, []);
}