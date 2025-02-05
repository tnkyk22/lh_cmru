import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_cmru/services/api_service.dart';
import 'package:lh_cmru/widgets/BottomBar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_wel.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'LEARN HUB CMRU',
                        style: GoogleFonts.libreBarcode128Text(
                          fontSize: 38,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        'Report',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF262626),
                        ),
                      ),
                      ReportTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class ReportTable extends StatefulWidget {
  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  ApiService apiService = ApiService();

  List<Map<String, dynamic>> data = [];

  Future<void> getReport() async {
    // ดึงข้อมูลจาก API
    try {
      final res = await apiService.get('/report_course');
      final data = res.data as List<dynamic>;
      setState(() {
        this.data = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getReport();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 50.0,
          columns: const [
            DataColumn(label: Text('Course', style: TextStyle(fontSize: 24))),
            DataColumn(label: Text('Count', style: TextStyle(fontSize: 24))),
          ],
          rows: data.map((item) {
            return DataRow(cells: [
              DataCell(Text(item['Course_Id'], style: TextStyle(fontSize: 22))),
              DataCell(Text(item['Sheet']?.length.toString() ?? '0',
                  style: TextStyle(fontSize: 22))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
