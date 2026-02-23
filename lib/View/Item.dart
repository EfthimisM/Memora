class Item {
  final String _name;
  final double _price;
  late bool selected = false;
  late int _type = 0;
  late int _order = 999;

  Item(this._name, this._price);

  String get name => _name;

  double get price => _price;

  bool get select => selected;

  int get type => _type;

  int get order => _order;

  set order(int or){
    _order = or;
  }

  set type(int str){
    _type = str;
  }

  @override
  String toString() => '$_name\t\t $_price';
}