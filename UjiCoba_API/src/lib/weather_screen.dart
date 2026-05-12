import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uji_coba_api/main.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();

  WeatherData? _weatherData;
  bool _isLoading = true;
  String? _errorMessage;

  // Kota default saat pertama buka (sesuaikan dengan kebutuhan)
  String _currentCity = 'Surabaya';

  @override
  void initState() {
    super.initState();
    _loadWeather(_currentCity);
  }

  Future<void> _loadWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _weatherService.getWeatherByCity(city);
      setState(() {
        _weatherData = data;
        _currentCity = city;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah kamu yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil
        (MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false);
      }
    }
  }

  void _showSearchDialog() {
    _cityController.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cari Kota'),
        content: TextField(
          controller: _cityController,
          decoration: const InputDecoration(
            hintText: 'Contoh: Jakarta, Bandung, Bali',
            prefixIcon: Icon(Icons.search),
          ),
          textCapitalization: TextCapitalization.words,
          onSubmitted: (val) {
            Navigator.pop(ctx);
            if (val.trim().isNotEmpty) _loadWeather(val.trim());
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              final val = _cityController.text.trim();
              if (val.isNotEmpty) _loadWeather(val);
            },
            child: const Text('Cari'),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(String? description) {
    if (description == null) return const Color(0xFF1565C0);
    final desc = description.toLowerCase();
    if (desc.contains('hujan') || desc.contains('rain')) {
      return const Color(0xFF37474F);
    } else if (desc.contains('mendung') || desc.contains('cloud')) {
      return const Color(0xFF455A64);
    } else if (desc.contains('cerah') || desc.contains('clear')) {
      return const Color(0xFF1565C0);
    } else if (desc.contains('kabut') || desc.contains('fog') || desc.contains('mist')) {
      return const Color(0xFF546E7A);
    }
    return const Color(0xFF1976D2);
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final bgColor = _getBackgroundColor(_weatherData?.description);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgColor, bgColor.withOpacity(0.7)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── AppBar Custom ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Text(
                        (user?.email ?? 'U')[0].toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat Datang,',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Text(
                            user?.email ?? 'Pengguna',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _showSearchDialog,
                      icon: const Icon(Icons.search, color: Colors.white),
                      tooltip: 'Cari Kota',
                    ),
                    IconButton(
                      onPressed: _logout,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      tooltip: 'Logout',
                    ),
                  ],
                ),
              ),

              // ── Konten Utama ──
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : _errorMessage != null
                        ? _buildErrorState()
                        : _buildWeatherContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 64, color: Colors.white70),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Terjadi kesalahan',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _loadWeather(_currentCity),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueGrey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    final w = _weatherData!;
    return RefreshIndicator(
      onRefresh: () => _loadWeather(_currentCity),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Nama Kota & Negara
            Text(
              '${w.cityName}, ${w.country}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Deskripsi cuaca
            Text(
              _capitalize(w.description),
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Ikon cuaca dari OpenWeatherMap
            Image.network(
              w.iconUrl,
              width: 120,
              height: 120,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.wb_cloudy,
                size: 100,
                color: Colors.white70,
              ),
            ),

            // Suhu utama
            Text(
              '${w.tempCelsius.toStringAsFixed(1)}°C',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w200),
            ),

            // Feels like
            Text(
              'Terasa seperti ${w.feelsLikeCelsius.toStringAsFixed(1)}°C',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),

            // Min / Max
            Text(
              '↑ ${w.tempMaxCelsius.toStringAsFixed(0)}°  ↓ ${w.tempMinCelsius.toStringAsFixed(0)}°',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 32),

            // Kartu Info Detail
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoTile(
                          Icons.water_drop, '${w.humidity}%', 'Kelembaban'),
                      _infoTile(Icons.air, '${w.windSpeed} m/s', 'Angin'),
                      _infoTile(Icons.visibility,
                          '${(w.visibility / 1000).toStringAsFixed(1)} km',
                          'Visibilitas'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tombol Refresh
            TextButton.icon(
              onPressed: () => _loadWeather(_currentCity),
              icon: const Icon(Icons.refresh, color: Colors.white70, size: 16),
              label: const Text(
                'Tarik ke bawah untuk refresh',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : w)
        .join(' ');
  }
}