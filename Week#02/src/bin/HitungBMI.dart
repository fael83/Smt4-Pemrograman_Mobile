import 'dart:io';

void main() {
  print("== Program Menghitung BMI ==");
  stdout.write("Masukkan berat badan (contoh: 55): ");
  double berat = double.parse(stdin.readLineSync()!);
  stdout.write("Masukkan tinggi badan (contoh: 1.7 / 1.72): ");
  double tinggi = double.parse(stdin.readLineSync()!);

  if (berat <= 0 || tinggi <= 0) {
    print("Input tidak boleh negatif atau 0");
    return;
  }

  // Menghitung BMI
  double bmi = (berat / (tinggi * tinggi));
  print("BMI = ${bmi.toStringAsFixed(1)}");

  // Kategori BMI
  if (bmi < 18.5) {
    print("Kategori: Berat Badan Kurang");
  } else if (bmi < 25) {
    print("Kategori: Berat Badan Normal / Ideal");
  } else if (bmi < 30) {
    print("Kategori: Berat Badan Lebih / Overweight");
  } else {
    print("Kategori: Obesitas");
  }
}
