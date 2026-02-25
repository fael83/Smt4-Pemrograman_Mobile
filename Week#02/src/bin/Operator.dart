import 'dart:io';

void main() {
  print("=== Program Demo Operator ===");
  stdout.write("Masukkan angka pertama: ");
  int angka1 = int.parse(stdin.readLineSync()!);
  stdout.write("Masukkan angka kedua: ");
  int angka2 = int.parse(stdin.readLineSync()!);

  print("--Operator Aritmatika--");
  print("angka1 + angka2 = ${angka1 + angka2}");
  print("angka1 - angka2 = ${angka1 - angka2}");
  print("angka1 * angka2 = ${angka1 * angka2}");
  print("angka1 / angka2 = ${angka1 / angka2}");
  print("angka1 ~/ angka2 = ${angka1 ~/ angka2}");
  print("angka1 % angka2 = ${angka1 % angka2}");

  print("\n--Operator Increment & Decrement--");
  angka1++;
  print("angka1++ = ${angka1}");
  angka2--;
  print("angka2-- = ${angka2}");

  // Mengembalikan ke angka semula
  angka1--;
  angka2++;

  print("\n--Operator Relasional--");
  print("angka1 == angka2 = ${angka1 == angka2}");
  print("angka1 != angka2 = ${angka1 != angka2}");
  print("angka1 > angka2 = ${angka1 > angka2}");
  print("angka1 < angka2 = ${angka1 < angka2}");
  print("angka1 >= angka2 = ${angka1 >= angka2}");
  print("angka1 <= angka2 = ${angka1 <= angka2}");

  print("\-- Operator Logika--");
  print("angka1 < 2 && angka2 > 3 = ${angka1 < 2 && angka2 > 3}");
  print("angka1 1 2 || angka2 > 3 = ${angka1 < 1 || angka2 > 4}");

  print("\n--Operator Penugasan--");
  print("angka 1 += angka 2 = ${angka1 + angka2}");
  print("angka 1 -= angka 2 = ${angka1 - angka2}");
  print("angka 1 *= angka 2 = ${angka1 * angka2}");
  print("angka 1 /= angka 2 = ${angka1 / angka2}");
  print("angka 1 ~/= angka 2 = ${angka1 ~/ angka2}");
  print("angka 1 %= angka 2 = ${angka1 % angka2}");

  print("\n--Operator Null-Aware--");
  String? nama;
  String hasilNama = nama ?? "Nama default";
  print("Nama: $hasilNama");

  print("\n--Operator Type Test--");
  print("angka1 is int = ${angka1 is int}");
  print("angka2 is! String = ${angka2 is! String}");

  print("\n--Operator Kondisional--");
  String hasil = (angka1 > angka2)
      ? "angka1 lebih besar"
      : "angka2 lebih besar atau sama";
  print(hasil);

  print("\n--Operator Bitwise--");
  print("angka1 & angka2 = ${angka1 & angka2}");
  print("angka1 | angka2 = ${angka1 | angka2}");
  print("angka1 ^ angka2 = ${angka1 ^ angka2}");
  print("angka2 << 1 = ${angka2 << 1}");
  print("angka1 >> 1 = ${angka1 >> 1}");

  print("\n--Prioritas Operator--");
  print("angka1 + angka2 * angka1 = ${angka1 + angka2 * angka1}"); // perkalian lebih dulu
  print("(angka1 + angka2) * angka1 = ${(angka1 + angka2) * angka1}"); //Pakai Kurung
}
