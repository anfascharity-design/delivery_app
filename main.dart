import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const TairAlzagelApp());
}

class TairAlzagelApp extends StatelessWidget {
  const TairAlzagelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طير الزاجل',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  // دالة للتحقق من الاتصال بالإنترنت
  Future<void> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طير الزاجل - خدمات التوصيل', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _checkInternetConnection,
            tooltip: 'إعادة المحاولة',
          )
        ],
      ),
      body: Center(
        child: _isConnected
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png', height: 150, errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.delivery_dining, size: 100, color: Colors.orange);
                    }),
                    const SizedBox(height: 20),
                    const Text(
                      'أهلاً بك في طير الزاجل',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'أسرع خدمات التوصيل بين يديك',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[800],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      onPressed: _checkInternetConnection,
                      icon: const Icon(Icons.wifi),
                      label: const Text('التحقق من الاتصال'),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.signal_wifi_off, size: 80, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    'لا يوجد اتصال بالإنترنت',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'يرجى التأكد من شبكة الإنترنت وإعادة المحاولة لاستخدام خدمات التطبيق.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800], foregroundColor: Colors.white),
                    onPressed: _checkInternetConnection,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
      ),
    );
  }
}
