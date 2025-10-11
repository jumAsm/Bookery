import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../models/BookModel.dart';
import 'package:bookery/constants/colors.dart';

class BookDetails extends StatefulWidget {
  final BookModel book;

  const BookDetails({super.key, required this.book});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late BookModel _book;

  @override
  void initState() {
    super.initState();
    _book = widget.book;
  }
  void _toggleBasketStatus() {
    final bool currentStatus = _book.isInBasket ?? false;
    setState(() {
      _book.isInBasket = !currentStatus;
      _book.save();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (_book.isInBasket ?? false) ? 'Book added to basket!' : 'Book removed from basket!',
          style: GoogleFonts.onest(),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isArabic = _book.language == 'Arabic';
    final CrossAxisAlignment horizontalAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final ImageProvider<Object> imageProvider =
    _book.coverUrl != null &&
        (_book.coverUrl!.startsWith('http') ||
            _book.coverUrl!.startsWith('https'))
        ? NetworkImage(_book.coverUrl!)
        : FileImage(File(_book.coverUrl!)) as ImageProvider<Object>;

   final bool inBasket = _book.isInBasket ?? false;

    return Scaffold(
      backgroundColor: backGroundClr,
      appBar: AppBar(
        backgroundColor: blues,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: backGroundClr, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
            IconButton(
            icon: Icon(Icons.bookmark_border, color: backGroundClr),
            onPressed: _toggleBasketStatus,
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.44,
                  decoration: BoxDecoration(
                    color: blues,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 55,
                  child: Container(
                    height: 250,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: const Offset(3, 6),
                        ),
                      ],
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _book.title ?? 'No Title',
                    style: GoogleFonts.unbounded(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: blacks,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 2),

                  Text(
                    'By ${_book.author ?? 'No Author'}',
                    style: GoogleFonts.onest(
                      fontSize: 14,
                      color: blacks.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index <
                            (double.tryParse(_book.rating ?? '0.0') ?? 0)
                                .round()
                            ? Icons.star
                            : Icons.star_border,
                        color: stars,
                        size: 20,
                      );
                    }),
                  ),

                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: GoogleFonts.unbounded(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: pinks,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Align(
                    alignment: horizontalAlignment == CrossAxisAlignment.end
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      _book.description ??
                          'No description available for this book.',
                      style: GoogleFonts.onest(fontSize: 14, color: blacks),
                      textAlign: horizontalAlignment == CrossAxisAlignment.end
                          ? TextAlign.right
                          : TextAlign.left,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Wrap(
                    spacing: 8.0,
                    children: [
                      Container(
                        height: 30,
                        width: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: greens, width: 2.2),
                        ),
                        child: Center(
                          child: Text(
                            _book.category ?? 'General',
                            style: GoogleFonts.onest(
                              color: blacks,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: pinks, width: 2.2),
                        ),
                        child: Center(
                          child: Text(
                            _book.language ?? 'English',
                            style: GoogleFonts.onest(
                              color: blacks,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blues, width: 2.2),
                        ),
                        child: Center(
                          child: Text(
                            '${_book.pages ?? 0} Pages',
                            style: GoogleFonts.onest(
                              color: blacks,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 25,right: 25, bottom: 15,top: 5),
        decoration: const BoxDecoration(color: backGroundClr),
        child: Row(
          children: [
            Text(
              '${_book.price ?? 0},00 SAR',
              style: GoogleFonts.unbounded(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: priceGr,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius:2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: _toggleBasketStatus,
                  icon: Icon(
                    inBasket ? Icons.check : Icons.add,
                    color: backGroundClr,
                    size: 18,
                  ),
                  label: Text(
                    inBasket ? 'In Basket' : 'Add to Basket',
                    style: GoogleFonts.unbounded(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: backGroundClr,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: inBasket ? greens : pinks,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}