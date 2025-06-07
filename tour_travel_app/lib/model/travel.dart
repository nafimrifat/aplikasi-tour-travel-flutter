class Travel {
  String? id;
  String? nama;
  String? lokasi;
  int? harga;
  String? deskripsi;
  String? durasi;

  Travel({
    this.id,
    this.nama,
    this.lokasi,
    this.harga,
    this.deskripsi,
    this.durasi,
  });

  factory Travel.fromJson(Map<String, dynamic> obj) {
    return Travel(
      id: obj['id'],
      nama: obj['nama'],
      lokasi: obj['lokasi'],
      harga: int.parse(obj['harga']),
      deskripsi: obj['deskripsi'],
      durasi: obj['durasi'],
    );
  }
}
