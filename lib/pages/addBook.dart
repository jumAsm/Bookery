import 'dart:io';
import 'package:bookery/widgets/TextFormFieldSet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/TextFormFieldSet.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/multiLineTextField.dart';
import '../cubits/add_book_cubit.dart';
import '../cubits/books_cubit.dart';
import 'package:bookery/constants/colors.dart';

class AddBook extends StatelessWidget {
  const AddBook({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final addBookCubit = BlocProvider.of<AddBookCubit>(context);
    addBookCubit.clearForm();

    List<Map<String, String>> categoryData = [
      {"key": "Literature", "label": "Literature"},
      {"key": "History", "label": "History"},
      {"key": "Fiction", "label": "Fiction"},
      {"key": "Business", "label": "Business"},
    ];
    List<Map<String, String>> languageData = [
      {"key": "English", "label": "English"},
      {"key": "Arabic", "label": "Arabic"},
    ];

    return BlocConsumer<AddBookCubit, AddBookState>(
      listener: (context, state) {
        if (state is AddBookSuccess) {
          BlocProvider.of<BooksCubit>(context).fetchAllBooks();
          Navigator.pop(context);
        } else if (state is AddBookFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save book: ${state.errorMessage}'),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddBookLoading;

        return Scaffold(
          backgroundColor: backGroundClr,
          body: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              size: 19,
                              color: blacks,
                            ),
                            onPressed: () {
                              addBookCubit.clearForm();
                              Navigator.pop(context);
                            },
                          ),

                          const Spacer(flex: 1),
                          Text(
                            "Sell Your Book",
                            style: GoogleFonts.unbounded(
                              fontSize: 16,
                              color: blacks,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () async {
                                final picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  addBookCubit.coverUrl = image.path;
                                }
                              },
                        child: Container(
                          height: 190,
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(color: blacks, width: 2.2),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            color: backGroundClr,
                            image:
                                addBookCubit.coverUrl != null &&
                                    addBookCubit.coverUrl!.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(
                                      File(addBookCubit.coverUrl!),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : addBookCubit.coverUrl == null ||
                                    addBookCubit.coverUrl!.isEmpty
                              ? const Center(
                                  child: Icon(
                                    Icons.add_photo_alternate,
                                    size: 38,
                                    color: blacks,
                                  ),
                                )
                              : null,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Column(
                        children: [
                          // PDF Upload Button
                          InkWell(
                            onTap: isLoading
                                ? null
                                : () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf'],
                                        );
                                    if (result != null) {
                                      addBookCubit.bookUrl =
                                          result.files.single.path;
                                    }
                                  },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              width: 160,
                              decoration: BoxDecoration(
                                color: blacks,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    addBookCubit.bookUrl != null
                                        ? Icons.check
                                        : Icons.file_upload_outlined,
                                    size: 18,
                                    color: backGroundClr,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    addBookCubit.bookUrl != null
                                        ? "File Ready"
                                        : "Upload Book File",
                                    style: GoogleFonts.onest(
                                      fontSize: 12,
                                      color: backGroundClr,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Visibility(
                            visible: addBookCubit.bookUrl != null,
                            child: InkWell(
                              onTap: () {
                                addBookCubit.bookUrl = null;
                              },
                              child: Icon(
                                Icons.delete_forever_outlined,
                                size: 28,
                                color: pinks,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Book Details',
                          style: GoogleFonts.unbounded(
                            color: pinks,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        TextFormFieldSet(
                          hintText: "Book Title",
                          icon: Icons.book,
                          onSaved: (value) => addBookCubit.title = value,
                        ),
                        const SizedBox(height: 10),
                        MultiLineTextField(
                          hintText: "Book Description",
                          onSaved: (value) => addBookCubit.description = value,
                          icon: Icons.short_text_sharp,
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldSet(
                          hintText: "Author Name",
                          icon: Icons.person,
                          onSaved: (value) => addBookCubit.author = value,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldSet(
                                hintText: "Pages",
                                isNumber: true,
                                icon: Icons.menu_book_rounded,
                                onSaved: (value) => addBookCubit.pages = value,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormFieldSet(
                                hintText: "Rating",
                                isNumber: true,
                                icon: Icons.star_rate,
                                onSaved: (value) => addBookCubit.rating = value,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldSet(
                          hintText: "Price (SAR)",
                          isNumber: true,
                          icon: Icons.payments_sharp,
                          onSaved: (value) => addBookCubit.price = value,
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          hint: Text(
                            "Select Category",
                            style: GoogleFonts.onest(
                              color: blacks,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: blacks,
                                width: 1.5,
                              ),
                            ),
                          ),
                          onSaved: (value) => addBookCubit.category = value,
                          isExpanded: true,
                          items: categoryData
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e["key"],
                                  child: Text(
                                    e["label"]!,
                                    style: GoogleFonts.onest(
                                      color: blacks,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            addBookCubit.category = value;
                          },
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          hint: Text(
                            "Select Language",
                            style: GoogleFonts.onest(
                              color: blacks,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: blacks,
                                width: 1.5,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          onSaved: (value) => addBookCubit.language = value,
                          items: languageData
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e["label"],
                                  child: Text(
                                    e["label"]!,
                                    style: GoogleFonts.onest(
                                      color: blacks,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            addBookCubit.language = value;
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    btnName: isLoading ? "Saving..." : "Save",
                    ontap: isLoading
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              addBookCubit.saveBook();
                            }
                          },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
