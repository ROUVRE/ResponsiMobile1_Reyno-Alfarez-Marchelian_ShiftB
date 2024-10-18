import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/tiket_bloc.dart';
import '/model/harga_tiket.dart';
import '/ui/tiket_detail.dart';
import '/ui/tiket_form.dart';
import 'login_page.dart';

class TiketPage extends StatefulWidget {
  const TiketPage({Key? key}) : super(key: key);
  @override
  _TiketPageState createState() => _TiketPageState();
}

class _TiketPageState extends State<TiketPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 182, 182),
        drawerTheme: const DrawerThemeData(
          backgroundColor: const Color.fromARGB(255, 255, 182, 182),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFC70039),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List Harga Tiket'),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  child: const Icon(Icons.add, size: 26.0),
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TiketForm()));
                  },
                ))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },
              )
            ],
          ),
        ),
        body: FutureBuilder<List>(
          future: TiketBloc.getTikets(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListTiket(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListTiket extends StatelessWidget {
  final List? list;
  const ListTiket({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return TiketProduk(
            hargaTiket: list![i],
          );
        });
  }
}

class TiketProduk extends StatelessWidget {
  final HargaTiket hargaTiket;
  const TiketProduk({Key? key, required this.hargaTiket}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TiketDetail(
                      hargaTiket: hargaTiket,
                    )));
      },
      child: Card(
        color: const Color(0xFFFFF5E0),
        child: ListTile(
          title: Text(hargaTiket.seat!),
          subtitle: Text(hargaTiket.price.toString()),
          trailing: Text(hargaTiket.event!),
        ),
      ),
    );
  }
}
