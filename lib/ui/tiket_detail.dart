import 'package:flutter/material.dart';
import 'package:manajemen_pariwisata/bloc/tiket_bloc.dart';
import 'package:manajemen_pariwisata/ui/tiket_page.dart';
import '../widget/warning_dialog.dart';
import '/model/harga_tiket.dart';
import '/ui/tiket_form.dart';

// ignore: must_be_immutable
class TiketDetail extends StatefulWidget {
  HargaTiket? hargaTiket;

  TiketDetail({Key? key, this.hargaTiket}) : super(key: key);

  @override
  _TiketDetailState createState() => _TiketDetailState();
}

class _TiketDetailState extends State<TiketDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Harga Tiket'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Event : ${widget.hargaTiket!.event}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Price : ${widget.hargaTiket!.price}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Seat : ${widget.hargaTiket!.seat}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFFFF5E0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TiketForm(
                  hargaTiket: widget.hargaTiket!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          child: const Text("DELETE"),
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFFFF5E0),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            TiketBloc.deleteTiket(id: widget.hargaTiket!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TiketPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
