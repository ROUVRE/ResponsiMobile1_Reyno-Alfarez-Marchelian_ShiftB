class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id/api/pariwisata';

  static const String registrasi =
      'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';
  static const String listTiket = baseUrl + '/harga_tiket';
  static const String createTiket = baseUrl + '/harga_tiket';

  static String updateTiket(int id) {
    return baseUrl +
        '/harga_tiket/' +
        id.toString() +
        '/update'; //sesuaikan dengan url API yang sudah dibuat
  }

  static String showTiket(int id) {
    return baseUrl +
        '/harga_tiket/' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }

  static String deleteTiket(int id) {
    return baseUrl +
        '/harga_tiket/' +
        id.toString() +
        '/delete'; //sesuaikan dengan url API yang sudah dibuat
  }
}
