import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/MyTextFormField.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/multiLineTextField.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  String? selectedCategory;
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categoryData = [
      {"key": "Literature", "label": "Literature"},
      {"key": "Science", "label": "Science"},
      {"key": "History", "label": "History"},
      {"key": "Fiction", "label": "Fiction"},
      {"key": "Business", "label": "Business"},
    ];
    List<Map<String, String>> languageData = [
      {"key": "English", "label": "English"},
      {"key": "Arabic", "label": "Arabic"},
    ];

    return Scaffold(
      backgroundColor: backGroundClr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 18),
              color: backGroundClr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 40),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                "Add New Book",
                                style: GoogleFonts.unbounded(
                                  fontSize: 22,
                                  color: blacks,
                                ),
                              ),
                            ),
                            SizedBox(width: 50),
                          ],
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 180,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: lightGreens,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                width: 180,
                                decoration: BoxDecoration(
                                  color: darkGreens,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file,
                                      size: 18,
                                      color: backGroundClr,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Upload Book File",
                                      style: GoogleFonts.unbounded(
                                        fontSize: 12,
                                        color: backGroundClr,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.delete_forever_outlined,
                              size: 28,
                              color: pinks,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  MyTextFormField(hintText: "Book title", icon: Icons.book),
                  SizedBox(height: 10),
                  MultiLineTextField(hintText: "Book Description"),
                  SizedBox(height: 10),
                  MyTextFormField(hintText: "Author Name", icon: Icons.person),
                  SizedBox(height: 10),
                  MyTextFormField(hintText: "About Author", icon: Icons.person),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Pages",
                    isNumber: true,
                    icon: Icons.pages_outlined,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Rating",
                    isNumber: true,
                    icon: Icons.rate_review,
                  ),
                  SizedBox(height: 10),
                  // Category Dropdown
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: lightGreens,
                          ),
                          child: DropdownButton<String>(
                            hint: Text(
                              selectedCategory ?? "Select Category",
                              style: GoogleFonts.zain(color: blacks, fontSize: 20),
                            ),
                            isExpanded: true,
                            items: categoryData.map((e) {
                              return DropdownMenuItem<String>(
                                value: e["key"],
                                child: Text(
                                  e["label"]!,
                                  style: GoogleFonts.zain(color: blacks, fontSize: 20),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children:[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: lightGreens,
                          ),
                          child: DropdownButton<String>(
                            hint: Text(
                              selectedLanguage ?? "Select Language",
                              style: GoogleFonts.zain(color: blacks, fontSize: 20),
                            ),
                            isExpanded: true,
                            items: languageData.map((e) {
                              return DropdownMenuItem<String>(
                                value: e["key"],
                                child: Text(
                                  e["label"]!,
                                  style: GoogleFonts.zain(color: blacks, fontSize: 20),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedLanguage = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                btnName: "Save",
                ontap: () {},
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PrimaryButton(
                btnName: "Cancel",
                ontap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
