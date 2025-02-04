import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_cmru/widgets/BottomBar.dart';
import 'package:lh_cmru/widgets/itemsWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  margin: const EdgeInsets.only(top: 5, left: 18, right: 18, bottom: 3),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: Icon(
                          Icons.signpost_outlined,
                          size: 32,
                          color: const Color(0xFF262626).withOpacity(0.6),
                        ),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                                icon: const Icon(Icons.cancel_rounded),
                                color: Colors.grey,
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              ),
                          )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onChanged: (value) {
                      setState(() {}); // อัปเดตไอคอนเมื่อพิมพ์ข้อความ
                    },
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.amber,
                  unselectedLabelColor: const Color(0xFF262626).withOpacity(0.5),
                  isScrollable: false,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4, color: Colors.amber),
                  ),
                  labelStyle: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w500),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 9),
                  tabs: const [
                    Tab(text: 'NOTE'),
                    Tab(text: 'SHEET'),
                    Tab(text: 'HANDOUT'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ItemsWidget(),
                      ItemsWidget(),
                      ItemsWidget(),
                      ItemsWidget(),
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
