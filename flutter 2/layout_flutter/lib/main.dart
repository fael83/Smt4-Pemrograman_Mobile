import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            /* soal 1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* soal 2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: const Text(
                    'Wisata Gunung Rinjani',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Lombok, Nusa Tenggara Barat, Indonesia',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /* soal 3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('5'),
        ],
      ),
    );

    Column _buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Gunung Rinjani (3.726 mdpl) di Pulau Lombok, Nusa Tenggara Barat, adalah gunung '
        'berapi aktif tertinggi kedua di Indonesia dan ikon pendakian dunia. Terkenal dengan '
        'pemandangan Danau Segara Anak dan puncak menantang, kawasan ini merupakan surga bagi pendaki dan pecinta alam. '
        'Rinjani menawarkan pengalaman mendalam dengan keindahan alam yang memukau, '
        'menjadikannya tujuan utama bagi para petualang yang mencari tantangan dan keindahan alam Indonesia.'
        'Nama: Moh Rafael Abrari, NIM: 244107060039🙂.',
        softWrap: true,
      ),
    );
    
    return MaterialApp(
      title: 'Flutter layout: Moh Rafael Abrari dan 244107060039',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'images/rinjani.jpeg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
              ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}