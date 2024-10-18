import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/harga_tiket.dart';

class TiketBloc {
  static Future<List<HargaTiket>> getTikets() async {
    String apiUrl = ApiUrl.listTiket;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTiket = (jsonObj as Map<String, dynamic>)['data'];
    List<HargaTiket> tikets = [];
    for (int i = 0; i < listTiket.length; i++) {
      tikets.add(HargaTiket.fromJson(listTiket[i]));
    }
    return tikets;
  }

  static Future addTiket({HargaTiket? HargaTiket}) async {
    String apiUrl = ApiUrl.createTiket;

    var body = {
      "event": HargaTiket!.event,
      "price": HargaTiket.price.toString(),
      "seat": HargaTiket.seat,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateTiket({required HargaTiket HargaTiket}) async {
    String apiUrl = ApiUrl.updateTiket(HargaTiket.id!);
    print(apiUrl);

    var body = {
      "event": HargaTiket.event,
      "price": HargaTiket.price,
      "seat": HargaTiket.seat
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteTiket({int? id}) async {
    String apiUrl = ApiUrl.deleteTiket(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
