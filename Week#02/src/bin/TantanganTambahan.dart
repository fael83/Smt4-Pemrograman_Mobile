import 'dart:io';
void main() {
  print('=== Aplikasi Konversi Unit Serbaguna ===');
  print('1. Panjang');
  print('2. Massa');
  print('3. Volume');
  print('4. Suhu');
  stdout.write('Masukkan pilihan (1-4): ');
  String? input = stdin.readLineSync();
  String? kategori = pilihKategori(input);
  if (kategori == 'Suhu') {
    konversiSuhu();
  } else if (kategori != null && dataKonversi.containsKey(kategori)) {
    konversiUmum(kategori, dataKonversi[kategori]!);
  } else {
    print('Pilihan tidak valid!');
  }
}

String? pilihKategori(String? pilihan) {
  switch (pilihan) {
    case '1':
      return 'Panjang';
    case '2':
      return 'Massa';
    case '3':
      return 'Volume';
    case '4':
      return 'Suhu';
    default:
      return null;
  }
}

  final Map<String, Map<String, double>> dataKonversi = {
    'Panjang': {
      'KM': 1000.0,
      'M': 1.0,
      'CM': 0.01,
      'MM': 0.001,
      'INCI': 0.0254,
    },
    'Massa': {
      'KG': 1000.0,
      'G': 1.0,
      'MG': 0.001,
      'ONS': 100.0,
      'PON': 453.59,
    },
    'Volume': {
      'M3': 1000.0,
      'LITER': 1.0,
      'ML': 0.001,
      'GALON': 3.785,
      'CANGKIR': 0.24,
    },
  };

void konversiUmum(String kategori, Map<String, double> unitMap) {
  print('\n--- Konversi $kategori ---');
  print('Unit tersedia: ${unitMap.keys.join(', ')}');

  stdout.write('Masukkan nilai: ');
  double nilai = double.tryParse(stdin.readLineSync() ?? '') ?? -1;

  if (nilai < 0) {
    print('Error: Nilai $kategori tidak boleh negatif!');
    return;
  }

  stdout.write('Dari unit: ');
  String dari = (stdin.readLineSync() ?? '').toUpperCase();

  stdout.write('Ke unit: ');
  String ke = (stdin.readLineSync() ?? '').toUpperCase();

  if (!unitMap.containsKey(dari) || !unitMap.containsKey(ke)) {
    print('Unit tidak ditemukan!');
    return;
  }

  double faktorAsal = unitMap[dari]!;
  double faktorTujuan = unitMap[ke]!;

  double nilaiDasar = nilai * faktorAsal;
  double hasilAkhir = nilaiDasar / faktorTujuan;

  print('\n[Hasil]: $nilai $dari = ${hasilAkhir.toStringAsFixed(4)} $ke');
}

void konversiSuhu() {
  print('\n--- Konversi Suhu (Celcius ke Lainnya) ---');

  stdout.write('Masukkan suhu dalam Celsius: ');
  double celsius = double.tryParse(stdin.readLineSync() ?? '') ?? 0;

  double fahrenheit = (celsius * 9 / 5) + 32;
  double kelvin = celsius + 273.15;
  double reamur = celsius * 4 / 5;

  print('\n[Hasil]:');
  print('$celsius°C = ${fahrenheit.toStringAsFixed(2)}°F');
  print('$celsius°C = ${kelvin.toStringAsFixed(2)} K');
  print('$celsius°C = ${reamur.toStringAsFixed(2)}°Re');
}