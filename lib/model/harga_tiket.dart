class HargaTiket {
  int? id;
  String? event;
  int? price;
  String? seat;

  HargaTiket({
    this.id,
    this.event,
    this.price,
    this.seat,
  });

  factory HargaTiket.fromJson(Map<String, dynamic> obj) {
    return HargaTiket(
      id: obj['id'],
      event: obj['event'],
      price: obj['price'],
      seat: obj['seat'],
    );
  }
}
