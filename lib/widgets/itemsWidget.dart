import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_cmru/services/api_service.dart';
import 'package:lh_cmru/services/share_pref_service.dart';
import 'package:lh_cmru/services/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> datas;

  const ItemsWidget({super.key, required this.datas});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  final ApiService apiService = ApiService();
  Future<void> _openPDF(BuildContext context, String pdfUrl) async {
    try {
      final uri = Uri.parse(getApiMedia('uploads/$pdfUrl'));
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch PDF'),
          ),
        );
      }
    } catch (e) {
      print('Error opening PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error opening PDF'),
        ),
      );
    }
  }

  Future<void> _addRating(int i, int rating) async {
    try {
      final userId = await SharePrefService()
          .getUserSession()
          .then((value) => value['userId']);
      final res = await apiService.post('/rating/${widget.datas[i]['Id']}', {
        'Score': rating,
        'userId': userId,
      });

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rating added successfully'),
          ),
        );
        setState(() {
          final existingRatingIndex = widget.datas[i]['Ratings'].indexWhere(
              (r) =>
                  r['userId'] == userId &&
                  r['sheetId'] == widget.datas[i]['Id']);
          if (existingRatingIndex != -1) {
            widget.datas[i]['Ratings'][existingRatingIndex]['Score'] = rating;
          } else {
            widget.datas[i]['Ratings'].add({
              'Score': rating,
              'userId': userId,
              'sheetId': widget.datas[i]['Id'],
            });
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error adding rating'),
          ),
        );
      }
    } catch (e) {
      print('Error adding rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Add any other widgets here if needed
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 150 / 190,
                ),
                itemCount: widget.datas.length,
                itemBuilder: (context, i) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            await _openPDF(context, widget.datas[i]['Path']);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: widget.datas[i]['NoteType'] == 'Note'
                                ? const Icon(
                                    Icons.book_rounded,
                                    size: 100,
                                    color: Colors.amber,
                                  )
                                : widget.datas[i]['NoteType'] == 'Sheet'
                                    ? const Icon(
                                        Icons.slideshow,
                                        size: 100,
                                        color: Colors.amber,
                                      )
                                    : const Icon(
                                        Icons.video_collection,
                                        size: 100,
                                        color: Colors.amber,
                                      ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.datas[i]['Name'],
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
                              widget.datas[i]['NoteType'],
                              style: TextStyle(
                                fontSize: 15,
                                color: const Color(0xff262626).withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // แสดงค่า Rating
                          Text(
                            'RATING: ${getRating(i).toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 12,
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
          ),
        ],
      ),
    );
  }

  double getRating(int i) {
    if (widget.datas[i]['Ratings']?.isNotEmpty == true) {
      var ratings = widget.datas[i]['Ratings'];
      var totalScore = ratings.map((e) => e['Score']).reduce((a, b) => a + b);
      return (totalScore / ratings.length) ?? 0;
    }
    return 0;
  }

  void _showRatingDialog(BuildContext context, int i) {
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
                  _addRating(i, rating + 1);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.star,
                  color: rating < 3 ? Colors.amber : Colors.grey,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
