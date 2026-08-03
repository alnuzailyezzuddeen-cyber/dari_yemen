import 'package:flutter/material.dart';

void main() {
  runApp(const DariYemenApp());
}

class DariYemenApp extends StatelessWidget {
  const DariYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'داري اليمن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainNavigationScreen(),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AddPropertyScreen(),
    const AdminDashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'إضافة عقار'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'الإدارة'),
        ],
      ),
    );
  }
}

// 1. الشاشة الرئيسية
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('داري اليمن 🏛️', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('عقارات مميزة في صنعاء وعدن 📍', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildPropertyCard('شقة فاخرة للإيجار', 'صنعاء - الحدة', '150,000 ر.ي / شهرياً', Icons.apartment, true),
          _buildPropertyCard('أرض استثمارية للبيع', 'عدن - المنصورة', '85,000 \$', Icons.landscape, false),
          _buildPropertyCard('هنجر ومستودع تجاري', 'صنعاء - الستين', '200,000 \$', Icons.store, true),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(String title, String location, String price, IconData icon, bool hasSolar) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF2563EB).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF2563EB)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$location ${hasSolar ? "• ☀️ طاقة شمسية" : ""}'),
        trailing: Text(price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// 2. شاشة إضافة عقار
class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  String _listingType = 'للإيجار';
  String _propertyType = 'شقة';
  String _governorate = 'صنعاء';
  bool _hasSolar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('إضافة عقار جديد 🏠', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('للإيجار')),
                    selected: _listingType == 'للإيجار',
                    onSelected: (val) => setState(() => _listingType = 'للإيجار'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('للبيع')),
                    selected: _listingType == 'للبيع',
                    onSelected: (val) => setState(() => _listingType = 'للبيع'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(labelText: 'عنوان العقار (المنطقة / الشارع)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'السعر', border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'المساحة (لبن / m²)', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('منظومة طاقة شمسية ☀️'),
              value: _hasSolar,
              onChanged: (val) => setState(() => _hasSolar = val!),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), foregroundColor: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال العقار بنجاح! 🚀')));
              },
              child: const Text('نشر العقار'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. لوحة تحكم الإدارة
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('لوحة الإدارة 👑', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'المؤشرات'),
            Tab(icon: Icon(Icons.approval), text: 'مراجعة الإعلانات'),
            Tab(icon: Icon(Icons.verified_user), text: 'توثيق المكاتب'),
            Tab(icon: Icon(Icons.payments), text: 'سندات الدفع'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAnalyticsTab(),
          const Center(child: Text('قائمة مراجعة الإعلانات')),
          const Center(child: Text('طلبات توثيق المكاتب')),
          const Center(child: Text('سندات التحويل المالي')),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('ملخص نشاط المنصة 📈', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            _buildStatCard('إجمالي العقارات', '1,248', Icons.home_work, Colors.blue),
            _buildStatCard('بانتظار الموافقة', '14', Icons.pending_actions, Colors.orange),
            _buildStatCard('المكاتب الموثقة', '86', Icons.verified, Colors.green),
            _buildStatCard('إجمالي الأرباح', '450,000 ر.ي', Icons.account_balance_wallet, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
