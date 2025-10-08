import 'package:flutter/material.dart';
import 'package:bookery/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/categorySetting.dart';
import '../widgets/recentAddedList.dart';
import '../widgets/recsList.dart';
import 'addBook.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundClr,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: backGroundClr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Text(
                          'Bookery',
                          style: GoogleFonts.sofadiOne(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: pinks),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.shopping_basket,
                          color: blacks,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search books...',
                        hintStyle: GoogleFonts.onest(
                          color: backGroundClr,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: blacks,
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: backGroundClr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                        Text(
                          'Categories',
                          style: GoogleFonts.unbounded(
                            fontSize: 16,
                            color: blacks,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Categorysetting(
                            label: 'Fiction',
                            borderClr: pinks,
                            selected: selectedCategory == 'Fiction',
                            onTap: () =>
                                setState(() => selectedCategory = 'Fiction'),
                          ),
                          const SizedBox(width: 8),
                          Categorysetting(
                            label: 'History',
                            borderClr: greens,
                            selected: selectedCategory == 'History',
                            onTap: () =>
                                setState(() => selectedCategory = 'History'),
                          ),
                          const SizedBox(width: 8),
                          Categorysetting(
                            label: 'Science',
                            borderClr: oranges,
                            selected: selectedCategory == 'Science',
                            onTap: () =>
                                setState(() => selectedCategory = 'Science'),
                          ),
                          const SizedBox(width: 8),
                          Categorysetting(
                            label: 'Business',
                            borderClr: darkGreens,
                            selected: selectedCategory == 'Business',
                            onTap: () =>
                                setState(() => selectedCategory = 'Business'),
                          ),
                          const SizedBox(width: 8),
                          Categorysetting(
                            label: 'Design',
                            borderClr: pinks,
                            selected: selectedCategory == 'Design',
                            onTap: () =>
                                setState(() => selectedCategory = 'Design'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Recently Added',
                      style: GoogleFonts.unbounded(
                        fontSize: 16,
                        color: blacks,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 22,
                      color: blacks,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),

              recentAddedList(),

              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Recommended for You',
                      style: GoogleFonts.unbounded(
                        fontSize: 16,
                        color: blacks,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 22,
                      color: blacks,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              recsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBook()),
          );
        },
        backgroundColor: pinks,
        child: const Icon(Icons.add),
      ),
    );
  }
}
