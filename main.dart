import 'package:flutter/material.dart';

void main() {
  runApp(const CustomerApp());
}

class CustomerApp extends StatelessWidget {
  const CustomerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق التوصيل - الزبون',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Roboto',
      ),
      home: const OrderScreen(),
    );
  }
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _selectedService = 'مطاعم وجبات';
  final List<String> _services = ['مطاعم وجبات', 'سوبرماركت ومقاضي', 'توصيل طرد خاص'];

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // تفاصيل الطلب جاهزة للإرسال إلى قاعدة البيانات
      final orderData = {
        'customerName': _nameController.text,
        'customerPhone': _phoneController.text,
        'serviceType': _selectedService,
        'addressDetails': _addressController.text,
        'orderDetails': _detailsController.text,
        'status': 'جديد',
        'timestamp': DateTime.now().toString(),
      };

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('تم إرسال الطلب بنجاح!'),
          content: Text('شكراً يا ${_nameController.text}، سيتم التواصل معك قريباً لتأكيد الطلب.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _detailsController.clear();
              },
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب توصيل جديد'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'بيانات الطلب والتوصيل',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 15),

              // الاسم
              TextFormField(
                controller: _nameController,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال الاسم' : null,
              ),
              const SizedBox(height: 12),

              // رقم الهاتف
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف / الواتساب',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 12),

              // نوع الخدمة
              DropdownButtonFormField<String>(
                value: _selectedService,
                decoration: const InputDecoration(
                  labelText: 'اختر نوع الخدمة',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _services.map((String service) {
                  return DropdownMenuItem(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedService = val!;
                  });
                },
              ),
              const SizedBox(height: 12),

              // العنوان والمعالم البارزة
              TextFormField(
                controller: _addressController,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'العنوان (المنطقة / معلم بارز)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال العنوان' : null,
              ),
              const SizedBox(height: 12),

              // تفاصيل اغراض الطلب
              TextFormField(
                controller: _detailsController,
                maxLines: 3,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'تفاصيل الطلب (اكتب الطلبات أو المكان المطلوب الشراء منه)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (val) => val == null || val.isEmpty ? 'يرجى كتابة تفاصيل الطلب' : null,
              ),
              const SizedBox(height: 20),

              // زر إرسال الطلب
              ElevatedButton(
                onPressed: _submitOrder,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('إرسال الطلب الآن', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}