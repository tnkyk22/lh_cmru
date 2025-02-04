import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({super.key});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  final List<String> img = ['1', '2', '3', '4'];
  final Map<int, int> ratings = {}; // เก็บค่าของ rating แต่ละ item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 150 / 185,
          ),
          itemCount: img.length,
          itemBuilder: (context, i) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    print("Tapped on item: ${img[i]}");
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/${img[i]}.jpg',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 150);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 4), // ลด Padding ให้ใกล้กัน
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          img[i],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff262626),
                          ),
                        ),
                        const SizedBox(
                            height:
                                2), // ลดระยะห่างระหว่าง Dynamic Tag และ Rating
                        Text(
                          'Dynamic Tag',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color(0xff262626).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // แสดงค่า Rating
                    Text(
                      'RATING: ${ratings[i] ?? 0} ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    // ปุ่มไอคอน Star สำหรับเลือกคะแนน
                    InkWell(
                      onTap: () => _showRatingDialog(context, i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Select Rating',
            style: GoogleFonts.pragatiNarrow(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (rating) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    ratings[index] = rating + 1; // บันทึกค่าคะแนน
                  });
                  Navigator.pop(context); // ปิด Dialog
                },
                icon: Icon(
                  Icons.star,
                  size: 35,
                  color: rating < (ratings[index] ?? 0)
                      ? Colors.amber
                      : Colors.grey,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
