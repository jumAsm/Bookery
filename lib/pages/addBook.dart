import 'dart:io';
import 'package:bookery/widgets/TextFormFieldSet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/multiLineTextField.dart';
import '../cubits/add_book_cubit.dart';
import '../cubits/books_cubit.dart';
import 'package:bookery/constants/colors.dart';
import '../models/BookModel.dart';

class AddBook extends StatefulWidget {
  final BookModel? existingBook;

  const AddBook({super.key, this.existingBook});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  bool _isOnSale = false;

  @override
  void initState() {
    super.initState();
    final addBookCubit = BlocProvider.of<AddBookCubit>(context, listen: false);
    if (widget.existingBook != null) {
      addBookCubit.initializeWithBook(widget.existingBook!);
    } else {
      addBookCubit.clearForm();
    }
    _isOnSale = addBookCubit.isOnSale ?? false;
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }
    return null;
  }

  String? _optionalNumericValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number for $fieldName';
    }
    return null;
  }

  String? _dropdownValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final addBookCubit = BlocProvider.of<AddBookCubit>(context);

    // تحديث حالة _isOnSale من الكيوبيت عند البناء
    if (addBookCubit.isOnSale != _isOnSale) {
      _isOnSale = addBookCubit.isOnSale ?? false;
    }

    List<Map<String, String>> categoryData = [
      {"key": "Fiction", "label": "Fiction"},
      {"key": "Literature", "label": "Literature"},
      {"key": "Psychology", "label": "Psychology"},
      {"key": "Art", "label": "Art"},
      {"key": "Poetry", "label": "Poetry"},
      {"key": "Biography", "label": "Biography"},
      {"key": "History", "label": "History"},
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 22,
                              color: blacks,
                            ),
                            onPressed: () {
                              addBookCubit.clearForm();
                              Navigator.pop(context);
                            },
                          ),

                          const Spacer(flex: 1),
                          Text(
                            widget.existingBook != null ? "Edit Book" : "Sell Your Book",
                            style: GoogleFonts.unbounded(
                              fontSize: 16,
                              color: blacks,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () async {
                          final picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            addBookCubit.updateCoverUrl(image.path);
                          }
                        },
                        child: Container(
                          height: 190,
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(color: blacks, width: 1.5),
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
                              size: 32,
                              color: blues,
                            ),
                          )
                              : null,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Column(
                        children: [
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
                                addBookCubit.updateBookUrl(
                                  result.files.single.path,
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              width: 160,
                              decoration: BoxDecoration(
                                color: blues,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    addBookCubit.bookUrl != null
                                        ? Icons.check
                                        : Icons.file_upload_outlined,
                                    size: 16,
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
                                      fontWeight: FontWeight.w500,
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
                                addBookCubit.updateBookUrl(null);
                              },
                              child: Icon(
                                Icons.delete_forever_outlined,
                                size: 24,
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
                          initialValue: addBookCubit.title,
                          hintText: "Book Title",
                          icon: Icons.book,
                          onSaved: (value) => addBookCubit.title = value,
                          validator: (value) =>
                              _requiredValidator(value, "Book Title"),
                        ),
                        const SizedBox(height: 10),
                        MultiLineTextField(
                          initialValue: addBookCubit.description,
                          hintText: "Book Description",
                          onSaved: (value) => addBookCubit.description = value,
                          icon: Icons.short_text_sharp,
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldSet(
                          initialValue: addBookCubit.author,
                          hintText: "Author Name",
                          icon: Icons.person,
                          onSaved: (value) => addBookCubit.author = value,
                          validator: (value) =>
                              _requiredValidator(value, "Author Name"),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldSet(
                                initialValue: addBookCubit.pages,
                                hintText: "Pages",
                                isNumber: true,
                                icon: Icons.menu_book_rounded,
                                onSaved: (value) => addBookCubit.pages = value,
                                validator: (value) =>
                                    _optionalNumericValidator(value, "Pages"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormFieldSet(
                                initialValue: addBookCubit.rating,
                                hintText: "Rating",
                                isNumber: true,
                                icon: Icons.star_rate,
                                onSaved: (value) => addBookCubit.rating = value,
                                validator: (value) =>
                                    _optionalNumericValidator(value, "Rating"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldSet(
                          initialValue: addBookCubit.price,
                          hintText: "Price (SAR)",
                          isNumber: true,
                          icon: Icons.payments_sharp,
                          onSaved: (value) => addBookCubit.price = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Price (SAR)';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number for Price (SAR)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField<String>(
                          value: addBookCubit.category,
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
                          validator: (value) =>
                              _dropdownValidator(value, "Category"),
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
                          value: addBookCubit.language,
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
                          validator: (value) =>
                              _dropdownValidator(value, "Language"),
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

                        Row(
                          children: [
                            Text(
                              'Is this book On Sale?',
                              style: GoogleFonts.unbounded(
                                color: blacks,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: _isOnSale,
                              onChanged: isLoading
                                  ? null
                                  : (value) {
                                setState(() {
                                  _isOnSale = value;
                                });
                                addBookCubit.updateOnSaleStatus(value);
                              },
                              activeColor: pinks,
                            ),
                          ],
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
                    btnName: isLoading
                        ? "Saving..."
                        : (widget.existingBook != null ? "Update" : "Save"),
                    ontap: isLoading
                        ? () {}
                        : () {
                      if (formKey.currentState!.validate()) {
                        if (addBookCubit.coverUrl == null ||
                            addBookCubit.bookUrl == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please ensure both the cover image and book file are uploaded.",
                                style: GoogleFonts.onest(),
                              ),
                              duration: const Duration(milliseconds: 1500),
                            ),
                          );
                          return;
                        }

                        formKey.currentState!.save();
                        addBookCubit.updateOnSaleStatus(_isOnSale);

                        addBookCubit.saveBook(existingBook: widget.existingBook);
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