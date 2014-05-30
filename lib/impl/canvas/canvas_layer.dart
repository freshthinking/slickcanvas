part of smartcanvas.canvas;

class CanvasLayer extends CanvasNode implements LayerImpl {

  List<CanvasTile> _tiles = new List<CanvasTile>();
  List<CanvasNode> _children = new List<CanvasNode>();
  bool _suspended = false;
  DOM.Element _element;
  Set<String> _classNames = new Set<String>();

  CanvasLayer(Layer shell): super(shell) {
    _element = new DOM.DivElement();
    _element.dataset['scNode'] = '${shell.uid}';
    _setElementAttributes();
    _setElementStyles();

    _updateTiles();

    _registerEvents();
  }

  void _setClassName() {
    _classNames.add(SC_CANVAS);
    if (hasAttribute(CLASS)) {
      _classNames.addAll(getAttribute(CLASS).split(SPACE));
    }
    setAttribute(CLASS, _classNames.join(SPACE));
  }

  void _setElementAttributes() {
    var attrs = _getElementAttributeNames();
    attrs.forEach(_setElementAttribute);
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from([ID, CLASS]);
  }

  void _setElementAttribute(String attr) {
    var value = getAttribute(attr);
    if (value != null) {
      if (!(value is String) || !value.isEmpty) {
        _element.attributes[attr] = '$value';
      }
    }
  }

  void _setElementStyles() {
    _element.style
    ..position = ABSOLUTE
    ..top = ZERO
    ..left = ZERO
    ..margin = ZERO
    ..padding = ZERO
    ..width = '${width}px'
    ..height = '${height}px';
  }

  void _updateTiles() {
    if (width != null && width > 0 &&
        height != null && height > 0) {
      num nTilesInRow = (width / CanvasTile.MAX_WIDTH).ceil();
      num nRows = (height / CanvasTile.MAX_HEIGHT).ceil();
      num nTiles = 0;
      num tileWidth = width / (width / CanvasTile.MAX_WIDTH).ceil();
      num tileHeight = height / (height / CanvasTile.MAX_HEIGHT).ceil();
      for (num i = 0; i < nRows; i++ ) {
        for (num j = 0; j < nTilesInRow; j++) {
          if ((i * nTilesInRow + j) < _tiles.length) {
            CanvasTile tile = _tiles[nTiles];
            _adjustTileSize(tile, tileWidth, tileHeight);
            ++nTiles;
            continue;
          } else {
            CanvasTile tile = new CanvasTile(this, {
              X: j * tileWidth,
              Y: i * tileHeight
            });
            _adjustTileSize(tile, tileWidth, tileHeight);
            _tiles.add(tile);
          }
          _element.append(_tiles.last._element);
          ++nTiles;
        }
      }

      while (nTiles < _tiles.length) {
        CanvasTile tile = _tiles[nTiles];
        tile.remove();
        _tiles.remove(tile);
      }
    }
  }

  void _adjustTileSize(CanvasTile tile, num tileWidth, num tileHeight) {
    if ((tile.x + tileWidth) > width) {
      tile.width = width - tile.x;
    } else {
      tile.width = tileWidth;
    }

    if ((tile.y + tileHeight) > height) {
      tile.height = height - tile.y;
    } else {
      tile.height = tileHeight;
    }
  }

  void _registerEvents() {
    shell
      .on('widthChanged', _onWidthChanged)
      .on('heightChanged', _onHeightChanged)
      .on('opacityChanged', _onOpacityChanged)
      .on('stageSet', _onStageSet);
  }

  void _onWidthChanged(oldValue, newValue) {
    _element.style.width = '${newValue}px';
    _updateTiles();
  }

  void _onHeightChanged(oldValue, newValue) {
    _element.style.height = '${newValue}px';
    _updateTiles();
  }

  void _onOpacityChanged(num oldValue, num newValue) {
    _element.style.opacity = '$newValue';
  }

  void _onStageSet() {

  }

  void add(CanvasNode node) {
  }

  void insert(int index, CanvasNode node) {
  }

  void removeChild(CanvasNode node) {
  }

  void suspend() {
    _suspended = true;
  }

  void resume() {
    _suspended = false;
    _draw();
  }

  void _draw() {
    if (!_suspended) {
      _tiles.forEach((tile) {
        tile.draw();
      });
    }
  }

  void remove() {
    _element.remove();
    if (parent != null) {
      (parent as Container).children.remove(this);
    }
    _tiles.forEach((tile) {
      tile.remove();
    });
    _tiles.clear();
    parent = null;
  }

  List<CanvasNode> get children => _children;
  DOM.Element get element => _element;

  Position get absolutePosition {
    return null;
  }
}