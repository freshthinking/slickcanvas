part of smartcanvas.canvas;

class CanvasPolygon extends CanvasGraphNode {
  CanvasPolygon(Polygon shell):super(shell) {
    this._useCache = true;
  }

  void _cacheGraph() {
    _cacheContext.clearRect(0, 0, _cacheCanvas.width, _cacheCanvas.height);
    _cacheContext.beginPath();
    List<Position> points = shell.points;
    num x = shell.x;
    num y = shell.y;
    for(int i = 0; i < points.length; i++) {
      if (i == 0) {
        _cacheContext.moveTo(points[i].x - x, points[i].y - y);
      } else {
        _cacheContext.lineTo(points[i].x - x, points[i].y - y);
      }
    }
    _cacheContext.closePath();
  }

  void __drawGraph(DOM.CanvasRenderingContext2D context) {}

  dynamic getAttribute(String attr, [dynamic defaultValue]) {
    switch(attr) {
      case X:
        return shell.x;
      case Y:
        return shell.y;
      case WIDTH:
        return shell.width;
      case HEIGHT:
        return shell.height;
      default:
        return super.getAttribute(attr, defaultValue);
    }
  }

  Polygon get shell => super.shell;
}