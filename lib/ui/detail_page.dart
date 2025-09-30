import 'package:flutter/material.dart';
import 'package:kuis_ppam_067/models/game_model.dart';
import 'package:kuis_ppam_067/data/game_data.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final int game;
  // bool isLike = true;
  const DetailPage({super.key, required this.game});

  @override
  State<DetailPage> createState() => _DetailPesanState();
}

class _DetailPesanState extends State<DetailPage> {
  final TextEditingController _controller = TextEditingController();
  int totalHarga = 0;
  String? _errorText;

  void _hitungTotal() {
    int? jumlah = int.tryParse(_controller.text);
    if (jumlah == null || jumlah <= 0) {
      setState(() {
        _errorText = "Jumlah tidak valid";
        totalHarga = 0;
      });
      return;
    }
    int harga = int.parse(gameList[widget.game].totalLike as String);
    setState(() {
      _errorText = null;
      totalHarga = jumlah * harga;
    });
  }

  Future<void> _launchWhatsApp(String phone, String message) async {
    final Uri url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp');
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri url = Uri(scheme: "tel", path: phone);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch phone dialer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  gameList[widget.game].gameImg,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              gameList[widget.game].gameName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              "${gameList[widget.game].gamePublisher} - ${gameList[widget.game].gamePublishDate}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${gameList[widget.game].totalLike} Likes",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            
            Icon(Icons.thumb_up_alt),
            const SizedBox(height: 20),
            Text(
              "${gameList[widget.game].gameDesc}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}