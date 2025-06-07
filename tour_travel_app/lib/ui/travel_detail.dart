import 'package:flutter/material.dart';
import 'package:tour_travel_app/bloc/tour_bloc.dart';
import 'package:tour_travel_app/model/travel.dart';
import 'package:tour_travel_app/ui/travel_form.dart';
import 'package:tour_travel_app/ui/travel_page.dart';
import 'package:tour_travel_app/widget/warning_dialog.dart';

class TravelDetail extends StatefulWidget {
  final Travel? travel;

  TravelDetail({Key? key, this.travel}) : super(key: key);

  @override
  _TravelDetailState createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Travel'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.white), //
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDetailCard(),
                  const SizedBox(height: 20),
                  _buildDeleteEditButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.travel?.nama ?? 'Nama tidak tersedia',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Lokasi: ${widget.travel?.lokasi ?? 'Lokasi tidak tersedia'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Harga: Rp. ${widget.travel?.harga?.toString() ?? '0'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Deskripsi: ${widget.travel?.deskripsi ?? 'Deskripsi tidak tersedia'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            Text(
              "Durasi: ${widget.travel?.durasi ?? 'Durasi tidak tersedia'}",
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteEditButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Tombol Edit
        ElevatedButton.icon(
          icon: const Icon(Icons.edit,
              color: Colors.white), // Mengatur warna ikon menjadi putih
          label: const Text(
            "EDIT",
            style: TextStyle(
              color: Colors.white, // Mengatur warna teks menjadi putih
              fontWeight: FontWeight.w500, // Mengatur teks menjadi tebal (bold)
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Warna latar belakang tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            // Mengatur warna teks dan ikon menjadi putih
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TravelForm(
                  travel: widget.travel!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        ElevatedButton.icon(
          icon: const Icon(Icons.delete,
              color: Colors.white), // Mengatur warna ikon menjadi putih
          label: const Text(
            "DELETE",
            style: TextStyle(
              color: Colors.white, // Mengatur warna teks menjadi putih
              fontWeight: FontWeight.w500, // Mengatur teks menjadi tebal (bold)
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Warna latar belakang tombol
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            // Mengatur warna teks dan ikon menjadi putih
          ),
          onPressed: () => _confirmDelete(),
        ),
      ],
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          // Tombol hapus
          OutlinedButton(
            child: const Text("Ya"),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog konfirmasi
              _deleteTravel(); // Panggil fungsi untuk menghapus data
            },
          ),
          // Tombol batal
          OutlinedButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context), // Tutup dialog konfirmasi
          ),
        ],
      ),
    );
  }

  void _deleteTravel() {
    setState(() {
      _isLoading = true;
    });

    TourBloc.deleteTour(id: widget.travel!.id!).then((status) {
      if (status) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const TravelPage(),
        ));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan hapus data gagal, silahkan coba lagi",
          ),
        );
      }
    }).catchError((error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Terjadi kesalahan, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
