import 'package:flutter/material.dart';
import 'package:tour_travel_app/bloc/logout_bloc.dart';
import 'package:tour_travel_app/bloc/tour_bloc.dart';
import 'package:tour_travel_app/model/travel.dart';
import 'package:tour_travel_app/ui/login_page.dart';
import 'package:tour_travel_app/ui/travel_detail.dart';
import 'package:tour_travel_app/ui/travel_form.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TravelForm()));
              },
            ),
          )
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()))
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Travel>>(
        future: TourBloc.getTours(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
                  list: snapshot.data ?? [],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List<Travel> list;

  const ListProduk({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return ItemTravel(
            travel: list[i],
          );
        });
  }
}

class ItemTravel extends StatelessWidget {
  final Travel travel;

  const ItemTravel({Key? key, required this.travel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TravelDetail(
                      travel: travel,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(travel.nama ?? 'No Name'),
          subtitle: Text(travel.harga?.toString() ?? '0'),
        ),
      ),
    );
  }
}
