import 'package:flutter/material.dart';
import '../bloc/tiket_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/harga_tiket.dart';
import 'tiket_page.dart';

// ignore: must_be_immutable
class TiketForm extends StatefulWidget {
  HargaTiket? hargaTiket;
  TiketForm({Key? key, this.hargaTiket}) : super(key: key);
  @override
  _TiketFormState createState() => _TiketFormState();
}

class _TiketFormState extends State<TiketForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TIKET";
  String tombolSubmit = "SIMPAN";
  final _eventTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _seatTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.hargaTiket != null) {
      setState(() {
        judul = "UBAH HARGA TIKET";
        tombolSubmit = "UBAH";
        _eventTextController.text = widget.hargaTiket!.event!;
        _priceTextController.text = widget.hargaTiket!.price.toString();
        _seatTextController.text = widget.hargaTiket!.seat!;
      });
    } else {
      judul = "TAMBAH HARGA TIKET";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _eventTextField(),
                _priceTextField(),
                _seatTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _eventTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Event"),
      keyboardType: TextInputType.text,
      controller: _eventTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kolom event harus diisi";
        }
        return null;
      },
    );
  }

  Widget _priceTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Price"),
      keyboardType: TextInputType.number,
      controller: _priceTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kolom price harus diisi";
        }
        return null;
      },
    );
  }

  Widget _seatTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Seat"),
      keyboardType: TextInputType.text,
      controller: _seatTextController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kolom seat harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.hargaTiket != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    HargaTiket updateTiket = HargaTiket(id: widget.hargaTiket!.id!);
    updateTiket.event = _eventTextController.text;
    updateTiket.price = int.parse(_priceTextController.text);
    updateTiket.seat = _seatTextController.text;
    TiketBloc.updateTiket(HargaTiket: updateTiket).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TiketPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    HargaTiket createTiket = HargaTiket(id: null);
    createTiket.event = _eventTextController.text;
    createTiket.seat = _seatTextController.text;
    createTiket.price = int.parse(_priceTextController.text);
    TiketBloc.addTiket(HargaTiket: createTiket).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TiketPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
