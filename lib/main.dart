import 'package:flutter/material.dart';

void main() {
  runApp(const DariYemenApp());
}

class DariYemenApp extends StatelessWidget {
  const DariYemenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'داري اليمن - لوحة الإدارة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: AdminDashboardScreen(),
      ),
    );
  }
}

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
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings, color: Colors.amber),
            SizedBox(width: 8),
            Text('لوحة تحكم الإدارة - داري اليمن', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.amber,
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
          _buildPendingPropertiesTab(),
          _buildOfficeVerificationTab(),
          _buildPaymentsTab(),
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

  Widget _buildPendingPropertiesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('إعلانات بانتظار الموافقة والنشر', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildPendingPropertyCard('هنجر ومستودع تجاري 600m²', 'صنعاء - الستين', 'المكتب: عقارات اليمن', '200,000 \$'),
        _buildPendingPropertyCard('أرض استثمارية للبيع 10 لبن', 'عدن - المنصورة', 'المالك: أحمد العنسي', '85,000 \$'),
      ],
    );
  }

  Widget _buildOfficeVerificationTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('طلبات توثيق المكاتب والوسطاء', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.blue.shade100, child: const Icon(Icons.business, color: Colors.blue)),
            title: const Text('مكتب الأمانة العقاري'),
            subtitle: const Text('رقم السجل التجاري: 10492 | صنعاء'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: () {},
              child: const Text('منح التوثيق 💙'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('إشعارات التحويل والمحافظ المالية 🧾', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildPaymentReceiptCard('كريمي إكسبرس / حاسب', 'المبلغ: 25,000 ر.ي', 'رقم السند: 9948201', 'ترقية إعلان مميز', Colors.blue),
        _buildPaymentReceiptCard('جيب (Jeeb)', 'المبلغ: 50,000 ر.ي', 'رقم العملية: JB-8821', 'اشتراك شهر للمكتب', Colors.purple),
        _buildPaymentReceiptCard('حوالة عبر النجم', 'المبلغ: 100 \$', 'رقم الحوالة: 7710293', 'توثيق حساب سنوي', Colors.orange),
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

  Widget _buildPendingPropertyCard(String title, String location, String publisher, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text('$location | $publisher', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const SizedBox(height: 6),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text('موافقة ونشر'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text('رفض'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentReceiptCard(String method, String amount, String refNo, String service, Color badgeColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: badgeColor.withOpacity(0.2),
          child: Icon(Icons.receipt_long, color: badgeColor),
        ),
        title: Text('$method - $amount', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text('$refNo\nالخدمة: $service', style: const TextStyle(fontSize: 12)),
        isThreeLine: true,
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), foregroundColor: Colors.white),
          onPressed: () {},
          child: const Text('تأكيد الدفع'),
        ),
      ),
    );
  }
}
