import 'package:flutter/material.dart';
import 'package:aplikasiantena/screens/dashboard_screen.dart';  // Pastikan mengimpor dashboard_screen.dart

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  _LoginScreensState createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  // Variabel untuk menyimpan data input
  String _selectedRole = 'mahasiswa'; // Default pilihan mahasiswa
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  void _navigateToDashboard() {
    // Mengambil nilai dari text controller dan mengirimkannya ke halaman Dashboard
    String name = nameController.text;
    String id = idController.text;

    // Pindahkan ke halaman Dashboard setelah login, membawa data nama dan id (NIM/NIP)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreens(
          name: name,
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Pilih Role: Mahasiswa atau Dosen
            Row(
              children: [
                Text("Mahasiswa"),
                Radio<String>(
                  value: 'mahasiswa',
                  groupValue: _selectedRole,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
                const SizedBox(width: 20),
                Text("Dosen"),
                Radio<String>(
                  value: 'dosen',
                  groupValue: _selectedRole,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
              ],
            ),
            // Form input untuk nama dan NIM/NIP
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama ${_selectedRole == "mahasiswa" ? "Mahasiswa" : "Dosen"}',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: _selectedRole == "mahasiswa" ? 'NIM' : 'NIP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Tombol Masuk
            ElevatedButton(
              onPressed: _navigateToDashboard,
              child: const Text("Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}
