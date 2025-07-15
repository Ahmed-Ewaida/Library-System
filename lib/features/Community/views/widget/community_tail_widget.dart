import 'package:flutter/material.dart';

import '../../../../Core/Models/Book.dart';
import '../../../Books/views/screens/book_details_screen.dart';
import '../../../Books/views/screens/book_status_screen.dart';
import '../../../Books/views/widget/custom_book_icon_widget.dart';
import '../../../Books/views/widget/custom_like_button_widget.dart';

class CommunityTail extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;
  final bool likeBotton;

  const CommunityTail({
    super.key,
    required this.book,
    required this.onTap,
    this.likeBotton = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, BookDetailsScreen.id);
      },
      child: Container(
        height: 130,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        BookReadButton(isBookSelected: likeBotton),
                        SizedBox(width: 10),
                        CustomLoveButton(isLiked: likeBotton),
                        SizedBox(width: 10),

                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 35,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     // builder: (context) => BookStatus(book: book),
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'حالة الكتاب',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(book.imageUrl, width: 50, height: 80),
                  SizedBox(height: 10),
                  Row(
                    children: List.generate(5, (index) {
                      if (book.rating < 3) {
                        return Icon(
                          Icons.star,
                          color: index < 2 ? Colors.yellow : Colors.grey[300],
                        );
                      } else if (book.rating == 3) {
                        return Icon(
                          Icons.star,
                          color: index < 3 ? Colors.yellow : Colors.grey[300],
                        );
                      } else {
                        return Icon(
                          Icons.star,
                          color: index < 4 ? Colors.yellow : Colors.grey[300],
                        );
                      }
                    }),
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
