import 'package:flutter/material.dart';
import 'package:tour_travel_app/bloc/tour_bloc.dart';
import 'package:tour_travel_app/model/travel.dart';
import 'package:tour_travel_app/ui/travel_page.dart';
import 'package:tour_travel_app/widget/warning_dialog.dart';

class TravelForm extends StatefulWidget {
  final Travel? travel;

  TravelForm({Key? key, this.travel}) : super(key: key);

  @override
  _TravelFormState createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Travel";
  String tombolSubmit = "SIMPAN";

  final _namaTextboxController = TextEditingController();
  final _lokasiTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _deskripsiTextboxController = TextEditingController();
  final _durasiTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.travel != null) {
      // Jika ada data travel yang diterima, artinya ini mode ubah
      judul = "UBAH Travel";
      tombolSubmit = "UBAH";
      _namaTextboxController.text = widget.travel?.nama ?? '';
      _lokasiTextboxController.text = widget.travel?.lokasi ?? '';
      _hargaTextboxController.text = widget.travel?.harga?.toString() ?? '0';
      _deskripsiTextboxController.text = widget.travel?.deskripsi ?? '';
      _durasiTextboxController.text = widget.travel?.durasi ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Memberi jarak pada semua sisi
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _namaTextField(),
                const SizedBox(height: 16.0), // Memberi jarak antar elemen
                _lokasiTextField(),
                const SizedBox(height: 16.0), // Memberi jarak antar elemen
                _hargaTextField(),
                const SizedBox(height: 16.0), // Memberi jarak antar elemen
                _deskripsiTextField(),
                const SizedBox(height: 16.0), // Memberi jarak antar elemen
                _durasiTextField(),
                const SizedBox(
                    height: 24.0), // Memberi jarak dengan tombol submit
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Travel"),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Travel harus diisi";
        }
        return null;
      },
    );
  }

  Widget _lokasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Lokasi"),
      keyboardType: TextInputType.text,
      controller: _lokasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Lokasi harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deskripsiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi"),
      keyboardType: TextInputType.text,
      controller: _deskripsiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deskripsi harus diisi";
        }
        return null;
      },
    );
  }

  Widget _durasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Durasi"),
      keyboardType: TextInputType.text,
      controller: _durasiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Durasi harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.travel != null) {
              // kondisi update produk
              _ubah();
            } else {
              // kondisi tambah produk
              _simpan();
            }
          }
        }
      },
      child: Text(
        tombolSubmit,
        style:
            TextStyle(color: Colors.white), // Mengatur warna teks tombol submit
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.teal, // Memberi warna latar belakang tombol submit
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 20.0), // Padding horizontal disesuaikan
      ),
    );
  }

  void _simpan() {
    setState(() {
      _isLoading = true;
    });

    Travel createTravel = Travel(
      nama: _namaTextboxController.text,
      lokasi: _lokasiTextboxController.text,
      harga: int.parse(_hargaTextboxController.text),
      deskripsi: _deskripsiTextboxController.text,
      durasi: _durasiTextboxController.text,
    );

    TourBloc.addTour(travel: createTravel).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const TravelPage(),
      ));
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _ubah() {
    setState(() {
      _isLoading = true;
    });

    Travel updateTravel = Travel(
      id: widget.travel!.id,
      nama: _namaTextboxController.text,
      lokasi: _lokasiTextboxController.text,
      harga: int.parse(_hargaTextboxController.text),
      deskripsi: _deskripsiTextboxController.text,
      durasi: _durasiTextboxController.text,
    );

    TourBloc.updateTour(travel: updateTravel).then((status) {
      print('Update status: $status');
      if (status) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TravelPage(),
        ));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
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
