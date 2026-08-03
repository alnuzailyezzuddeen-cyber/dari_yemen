import 'package:flutter/material.dart';

void main() {
  runApp(const DariYemenApp());
}

class DariYemenApp extends StatelessWidget {
  const DariYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'داري اليمن - إضافة عقار',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: AddPropertyScreen(),
      ),
    );
  }
}

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();

  // بيانات النموذج
  String _listingType = 'للإيجار'; // للبيع أو للإيجار
  String _propertyType = 'شقة';
  String _governorate = 'صنعاء';
  bool _hasSolar = false;
  bool _hasWaterTank = false;
  bool _hasParking = false;

  final List<String> _propertyTypes = ['شقة', 'بيت / فيلا', 'أرض', 'هنجر / مستودع', 'محل تجاري', 'عمارة'];
  final List<String> _governorates = ['صنعاء', 'عدن', 'تعز', 'إب', 'الحديدة', 'حضرموت', 'مأرب'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('إضافة عقار جديد 🏠', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 1. نوع العرض (للبيع / للإيجار)
            const Text('نوع العرض', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('للإيجار')),
                    selected: _listingType == 'للإيجار',
                    selectedColor: const Color(0xFF2563EB),
                    labelStyle: TextStyle(color: _listingType == 'للإيجار' ? Colors.white : Colors.black),
                    onSelected: (selected) {
                      setState(() => _listingType = 'للإيجار');
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('للبيع')),
                    selected: _listingType == 'للبيع',
                    selectedColor: const Color(0xFF2563EB),
                    labelStyle: TextStyle(color: _listingType == 'للبيع' ? Colors.white : Colors.black),
                    onSelected: (selected) {
                      setState(() => _listingType = 'للبيع');
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. نوع العقار والمحافظة
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _propertyType,
                    decoration: const InputDecoration(labelText: 'نوع العقار', border: OutlineInputBorder()),
                    items: _propertyTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                    onChanged: (val) => setState(() => _propertyType = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _governorate,
                    decoration: const InputDecoration(labelText: 'المحافظة', border: OutlineInputBorder()),
                    items: _governorates.map((gov) => DropdownMenuItem(value: gov, child: Text(gov))).toList(),
                    onChanged: (val) => setState(() => _governorate = val!),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 3. عنوان العقار التفصيلي
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'عنوان العقار (المنطقة / الشارع)',
                hintText: 'مثال: الستين الغربي - خلف مستشفى أباظة',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty ? 'يرجى إدخال العنوان' : null,
            ),

            const SizedBox(height: 16),

            // 4. السعر والمساحة
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'السعر',
                      hintText: 'مثال: 150,000',
                      suffixText: 'ر.ي / \$',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'المساحة',
                      hintText: 'مثال: 4 لبن / 120m²',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 5. مميزات إضافية (طاقة شمسية، خزان...)
            const Text('المميزات المتاحة ✨', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            CheckboxListTile(
              title: const Text('منظومة طاقة شمسية ☀️'),
              value: _hasSolar,
              onChanged: (val) => setState(() => _hasSolar = val!),
            ),
            CheckboxListTile(
              title: const Text('خزان ماء أرضي مستقل 💧'),
              value: _hasWaterTank,
              onChanged: (val) => setState(() => _hasWaterTank = val!),
            ),
            CheckboxListTile(
              title: const Text('موقف سيارات / كراج 🚗'),
              value: _hasParking,
              onChanged: (val) => setState(() => _hasParking = val!),
            ),

            const SizedBox(height: 16),

            // 6. زر إضافة الصور (محاكاة)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFF2563EB)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo, color: Color(0xFF2563EB)),
              label: const Text('إرفاق صور العقار (حتى 6 صور)', style: TextStyle(color: Color(0xFF2563EB))),
            ),

            const SizedBox(height: 24),

            // 7. زر حفظ ونشر العقار
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إرسال العقار للمراجعة بنجاح! 🚀')),
                    );
                  }
                },
                child: const Text('نشر العقار الآن', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
