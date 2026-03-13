import 'dart:ffi';
import 'dart:io';

void main() {
  String nama = "Moh Rafael Abrari", nim = "244107060039";
  double nilaiUnikNIM = 039;

  List<double> hargaBarang = [
    100000, 250000, 300000, 500000, 50000
  ];

  hargaBarang.add(nilaiUnikNIM);

  String? pesanDiskon;

  double hitungTotal(List<double> hitungHarga){
    double total = 0;
    for (double harga in hitungHarga) {
      total += harga;
    }
    return total;
  }

  double totalBelanja = hitungTotal(hargaBarang);

  double diskon = 0;
  if (totalBelanja > 200000) {
    diskon = totalBelanja * 0.10;
    pesanDiskon = "Mendapatkan Diskon 10%";
  } else if (totalBelanja >= 100000 && totalBelanja <= 200000){
    diskon = totalBelanja * 0.05;
    pesanDiskon = "Mendapatkan Diskon 5%";
  } else {
    diskon = 0;
    pesanDiskon = "Tidak mendapatkan diskon";
  }

  double totalAkhir = totalBelanja - diskon;

  print("Nama: $nama");
  print("NIM: $nim");
  print("Total Belanja Awal: $totalBelanja");
  print("Keterangan Diskon: ${pesanDiskon!}");
  print("Diskon: ${diskon.toStringAsFixed(1)}");
  print("Total Akhir Belanja: $totalAkhir");
}
