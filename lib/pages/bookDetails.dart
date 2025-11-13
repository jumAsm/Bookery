import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import 'package:bookery/constants/colors.dart';
import 'BasketPage.dart';
import 'addBook.dart';

class BookDetails extends StatefulWidget {
  final BookModel book;
  final bool isOwned;

  const BookDetails({super.key, required this.book, this.isOwned = false});

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

  void _toggleBookmarkStatus() {
    setState(() {
      _book.isBookmarked = !(_book.isBookmarked ?? false);
      _book.save();
    });

    BlocProvider.of<BooksCubit>(context).fetchAllBooks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (_book.isBookmarked ?? false)
              ? 'Book added to bookmarks!'
              : 'Book removed from bookmarks!',
          style: GoogleFonts.onest(),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void _toggleFavoriteStatus() {
    setState(() {
      _book.isFavorite = !(_book.isFavorite ?? false);
      _book.save();
    });

    BlocProvider.of<BooksCubit>(context).fetchAllBooks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (_book.isFavorite ?? false)
              ? 'Book added to favorites!'
              : 'Book removed from favorites!',
          style: GoogleFonts.onest(),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void _toggleBasketStatus() {
    final bool currentStatus = _book.isInBasket ?? false;

    if (currentStatus) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BasketPage()),
      );
    } else {
      setState(() {
        _book.isInBasket = true;
        _book.save();
      });

      BlocProvider.of<BooksCubit>(context).fetchAllBooks();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Book added to basket!', style: GoogleFonts.onest()),
          duration: const Duration(milliseconds: 1000),
        ),
      );
    }
  }

  void _readBook() {
    if (_book.bookurl != null && _book.bookurl!.isNotEmpty) {
      print('Attempting to open PDF at: ${_book.bookurl}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Opening: "${_book.title}"...',
            style: GoogleFonts.onest(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cannot read: Book file not found.',
            style: GoogleFonts.onest(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _editBook() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBook(existingBook: _book)),
    ).then((_) {
      context.read<BooksCubit>().fetchAllBooks();
    });
  }

  void _deleteBookLogic() {
    context.read<BooksCubit>().deleteBook(_book.id!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Book deleted successfully from market.',
          style: GoogleFonts.onest(),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: backGroundClr,
          title: Text(
            "Confirm Deletion",
            style: GoogleFonts.unbounded(color: pinks),
          ),
          content: Text(
            "Are you sure you want to delete \"${_book.title}\" from the market?",
            style: GoogleFonts.onest(color: blacks),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text("Cancel", style: GoogleFonts.unbounded(color: blues)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _deleteBookLogic();
              },
              child: Text("Delete", style: GoogleFonts.unbounded(color: pinks)),
            ),
          ],
        );
      },
    );
  }

  void _updateReadingStatus(String? newStatus) {
    if (newStatus == null) return;
    setState(() {
      _book.readingStatus = newStatus;
      _book.save();
    });

    BlocProvider.of<BooksCubit>(context).fetchAllBooks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reading status updated to: $newStatus',
          style: GoogleFonts.onest(),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  ImageProvider<Object> _getImageProvider(String? coverUrl) {
    if (coverUrl == null || coverUrl.isEmpty) {
      return const AssetImage('assets/placeholder.png');
    }

    if (coverUrl.startsWith('http') || coverUrl.startsWith('https')) {
      return NetworkImage(coverUrl);
    } else {
      return FileImage(File(coverUrl));
    }
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
    final bool isOwned = widget.isOwned;
    final bool isOnSale = _book.isOnSale ?? false;

    String buttonText = '';
    IconData buttonIcon = Icons.error;
    Color buttonColor = pinks;
    VoidCallback onPressedAction = () {};
    bool showPrice = true;
    bool isActionHidden = false;

    if (isOwned) {
      buttonText = 'Read Now';
      buttonIcon = Icons.menu_book_rounded;
      buttonColor = blues;
      onPressedAction = _readBook;
      showPrice = false;
    } else if (isOnSale) {
      isActionHidden = true;
    } else {
      buttonText = inBasket ? 'In Basket' : 'Add to Basket';
      buttonIcon = inBasket ? Icons.check : Icons.add;
      buttonColor = inBasket ? blues : pinks;
      onPressedAction = _toggleBasketStatus;
    }

    return Scaffold(
      backgroundColor: backGroundClr,
      appBar: AppBar(
        backgroundColor: blues,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: backGroundClr,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (isOnSale) ...[
            IconButton(
              icon: const Icon(Icons.edit, color: backGroundClr, size: 22),
              onPressed: _editBook,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: pinks,
                size: 22,
              ),
              onPressed: _confirmDelete,
            ),
            const SizedBox(width: 8),
          ] else ...[
            if (widget.isOwned)
              IconButton(
                icon: Icon(
                  (_book.isFavorite ?? false)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: (_book.isFavorite ?? false) ? pinks : backGroundClr,
                  size: 22,
                ),
                onPressed: _toggleFavoriteStatus,
              ),

            IconButton(
              icon: Icon(
                (_book.isBookmarked ?? false)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: (_book.isBookmarked ?? false) ? stars : backGroundClr,
                size: 22,
              ),
              onPressed: _toggleBookmarkStatus,
            ),
            const SizedBox(width: 8),
          ],
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
                  height: 300,
                  decoration: const BoxDecoration(
                    color: blues,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
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
                    children: [
                      ...List.generate(5, (index) {
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
                      const SizedBox(width: 8),
                      Text(
                        '${_book.rating ?? '0.0'}',
                        style: GoogleFonts.onest(
                          fontSize: 14,
                          color: blacks,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (isOnSale)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${_book.price ?? 0},00 SR',
                        style: GoogleFonts.unbounded(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: priceGr,
                        ),
                      ),
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

      bottomNavigationBar: isActionHidden
          ? Container(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 5),
        decoration: const BoxDecoration(color: backGroundClr),
        child: SafeArea(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: blues,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'This Book is Listed on Market',
              style: GoogleFonts.unbounded(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: backGroundClr,
              ),
            ),
          ),
        ),
      )
          : Container(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 5),
        decoration: const BoxDecoration(color: backGroundClr),
        child: isOwned
            ? Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 43,
                decoration: BoxDecoration(
                  color: backGroundClr,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: blues, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _book.readingStatus ?? 'On Going',
                    icon: Icon(Icons.arrow_drop_down, color: blues),
                    style: GoogleFonts.onest(fontSize: 14, color: blacks),
                    dropdownColor: backGroundClr,
                    onChanged: _updateReadingStatus,
                    items: <String>['On Going', 'Completed']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.onest(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: value == (_book.readingStatus ?? 'On Going') ? blues : blacks,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container( // زر Read Now
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: _readBook,
                  icon: Icon(
                    Icons.menu_book_rounded,
                    color: backGroundClr,
                    size: 18,
                  ),
                  label: Text(
                    'Read Now',
                    style: GoogleFonts.unbounded(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: backGroundClr,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blues,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            : Row(
          children: [
            if (showPrice)
              Text(
                '${_book.price ?? 0},00 SR',
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
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SizedBox(
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: onPressedAction,
                  icon: Icon(
                    buttonIcon,
                    color: backGroundClr,
                    size: 18,
                  ),
                  label: Text(
                    buttonText,
                    style: GoogleFonts.unbounded(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: backGroundClr,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
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