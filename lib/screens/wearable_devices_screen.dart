import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/app_config.dart';

class WearableDevicesScreen extends StatefulWidget {
  const WearableDevicesScreen({super.key});

  @override
  State<WearableDevicesScreen> createState() => _WearableDevicesScreenState();
}

class _WearableDevicesScreenState extends State<WearableDevicesScreen> {
  bool _isScanning = false;
  // Mock List
  final List<Map<String, dynamic>> _devices = [
    {
      'name': 'Rakhi Safety Band',
      'id': 'SB-2024-XJZ',
      'battery': 85,
      'status': 'Connected',
      'icon': Icons.watch_rounded,
      'color': AppTheme.primaryMaroon,
    },
    {
      'name': 'Smart Pendant',
      'id': 'SP-V2-009',
      'battery': 12,
      'status': 'Disconnected',
      'icon': Icons.diamond_outlined,
      'color': Colors.grey,
    },
  ];

  void _scanForDevices() async {
    setState(() => _isScanning = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _isScanning = false;
        // Simulate finding a new device
        if (_devices.length < 3) {
          _devices.add({
            'name': 'Keyring SOS',
            'id': 'KR-555-ABC',
            'battery': 100,
            'status': 'Available',
            'icon': Icons.vpn_key_rounded,
            'color': AppTheme.safeGreen,
          });
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Scan complete. Found 1 new device.'),
          backgroundColor: AppTheme.safeGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(AppConfig.wearableTitle),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: AppTheme.textPrimary),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryMaroon, AppTheme.primaryMaroon.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryMaroon.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bluetooth_audio_rounded,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Keep Connected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pair your safety devices to trigger SOS automatically.',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().slideY(begin: -0.2, end: 0, duration: 600.ms),

          // List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Devices',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                if (_isScanning)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return _buildDeviceCard(device, index);
              },
            ),
          ),

          // Scan Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isScanning ? null : _scanForDevices,
                icon: const Icon(Icons.search_rounded),
                label: Text(_isScanning ? 'Scanning...' : AppConfig.wearableScanButton),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 1.0, end: 0),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device, int index) {
    final bool isConnected = device['status'] == 'Connected';
    final Color color = isConnected ? AppTheme.safeGreen : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isConnected ? AppTheme.safeGreen.withValues(alpha: 0.3) : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (device['color'] as Color).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(device['icon'], color: device['color'], size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: ${device['id']}',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  device['status'],
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (device.containsKey('battery'))
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      device['battery'] > 20
                          ? Icons.battery_full_rounded
                          : Icons.battery_alert_rounded,
                      size: 16,
                      color: device['battery'] > 20 ? Colors.grey : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${device['battery']}%',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.2, end: 0);
  }
}
