import 'package:flutter/material.dart';
import 'dart:math';

class kompas extends StatefulWidget {
  const kompas({super.key});

  @override
  _KompasScreenState createState() => _KompasScreenState();
}

class _KompasScreenState extends State<kompas> {
  double _azimut = 0; // Mengatur azimut awal
  double _elevasi = 0; // Mengatur elevasi awal
  List<Map<String, String>> historyList = []; // Menyimpan history pengukuran
  String _selectedAngleType = 'Azimut'; // Menyimpan pilihan sudut (Azimut atau Elevasi)

  // Fungsi untuk menambah history ke list
  void _addHistory() {
    final DateTime now = DateTime.now();
    historyList.add({
      'Datetime': '${now.month}/${now.day}/${now.year} ${now.hour}:${now.minute}:${now.second}',
      'Azimut': '$_azimut°',
      'Elevasi': '$_elevasi°',
    });
    setState(() {});
  }

  // Fungsi untuk memperhalus gerakan azimut atau elevasi
  void _updateAngle(double dx) {
    setState(() {
      if (_selectedAngleType == 'Azimut') {
        _azimut = (_azimut + dx * 0.2) % 360; // Menggunakan dx untuk memperhalus gerakan
        if (_azimut < 0) _azimut += 360; // Menghindari nilai negatif
      } else {
        _elevasi = (_elevasi + dx * 0.2) % 360;
        if (_elevasi < 0) _elevasi += 360;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kompas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pilihan untuk Azimut atau Elevasi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Azimut',
                  groupValue: _selectedAngleType,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAngleType = value!;
                    });
                  },
                ),
                const Text('Azimut'),
                Radio<String>(
                  value: 'Elevasi',
                  groupValue: _selectedAngleType,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAngleType = value!;
                    });
                  },
                ),
                const Text('Elevasi'),
              ],
            ),
            const SizedBox(height: 20),
            
            // Menggambar lingkaran derajat
            Center(
              child: GestureDetector(
                onPanUpdate: (details) {
                  _updateAngle(details.localPosition.dx);  // Memperhalus gesekan
                },
                child: CustomPaint(
                  size: Size(250, 250),  // Ukuran area gambar
                  painter: KompasPainter(
                    _azimut, // Menggunakan nilai azimut
                    _elevasi, // Menggunakan nilai elevasi
                    _selectedAngleType
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tampilkan derajat azimut dan elevasi
            Text('$_selectedAngleType: ${(_selectedAngleType == 'Azimut' ? _azimut : _elevasi).toStringAsFixed(2)}°'),
            const SizedBox(height: 20),
            // Tombol untuk menambah history
            Center(
              child: ElevatedButton(
                onPressed: _addHistory,
                child: const Text('Terapkan dan Simpan History'),
              ),
            ),
            const SizedBox(height: 20),
            // History pengukuran
            const Text(
              'History Pengukuran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final history = historyList[index];
                  return Card(
                    child: ListTile(
                      title: Text('Datetime: ${history['Datetime']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Azimut: ${history['Azimut']}'),
                          Text('Elevasi: ${history['Elevasi']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter untuk menggambar kompas dengan lingkaran derajat dan penunjuk azimut/elevasi
class KompasPainter extends CustomPainter {
  final double azimut;
  final double elevasi;
  final String angleType;

  KompasPainter(this.azimut, this.elevasi, this.angleType);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Paint linePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Menentukan pusat dan radius lingkaran
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    // Menggambar lingkaran kompas
    canvas.drawCircle(center, radius, circlePaint);

    // Menggambar penunjuk azimut atau elevasi (panah)
    double angleInRadians = (angleType == 'Azimut' ? azimut : elevasi - 90) * (pi / 180);  // Mengkonversi azimut/elevasi ke radian
    Offset arrowStart = center;
    Offset arrowEnd = Offset(
      center.dx + radius * cos(angleInRadians),
      center.dy + radius * sin(angleInRadians),
    );

    // Menggambar garis penunjuk arah (azimut/elevasi)
    canvas.drawLine(arrowStart, arrowEnd, linePaint);

    // Menggambar derajat pada lingkaran (0-360 derajat)
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '0°',
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 10, center.dy - radius + 10));

    // Tampilkan derajat lainnya (untuk 90°, 180°, 270°)
    textPainter.text = TextSpan(
      text: '90°',
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx + radius - 20, center.dy - 10));

    textPainter.text = TextSpan(
      text: '180°',
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 10, center.dy + radius - 30));

    textPainter.text = TextSpan(
      text: '270°',
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - radius + 10, center.dy - 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
