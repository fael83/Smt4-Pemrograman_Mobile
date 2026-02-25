import 'dart:io';

void main() {
  print("== Program Mengkonversi Mata Uang ==");
  int USD = 16794, SAR = 4476, MYR = 4318;

  stdout.write("Masukkan Nominal Uang: Rp");
  int rupiah = int.parse(stdin.readLineSync()!);

  // Validasi
  if (rupiah <= 0) {
    print("Nominal tidak boleh negatif atau 0");
    return;
  }

  // Perhitungan
  double usd = rupiah / USD;
  double sar = rupiah / SAR;
  double myr = rupiah / MYR;

  print("Hasil Konversi");
  print("USD: ${usd.toStringAsFixed(2)}");
  print("SAR: ${sar.toStringAsFixed(2)}");
  print("MYR: ${myr.toStringAsFixed(2)}");
}
