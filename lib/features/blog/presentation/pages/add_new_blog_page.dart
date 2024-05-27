import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static addNewBlogRoute() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final _titleController = TextEditingController();
  final _contentContorller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uplaodBlog() {
    if (_formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserSignedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
              posterId: posterId,
              title: _titleController.text.trim(),
              content: _contentContorller.text.trim(),
              image: image!,
              topics: selectedTopics,
            ),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentContorller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: (() {
            uplaodBlog();
          }),
          icon: const Icon(Icons.done_rounded),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<BlogBloc, BlogState>(
              listener: (context, state) {
                if (state is BlogFailure) {
                  showSnackBar(context, state.error);
                } else if (state is BlogUploadSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    BlogPage.blogPageRoute(),
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                if (state is BlogLoading) {
                  return const Loader();
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        image != null
                            ? GestureDetector(
                                onTap: () => selectImage(),
                                child: SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () => selectImage(),
                                child: DottedBorder(
                                  color: AppPallete.borderColor,
                                  dashPattern: const [10, 4],
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.folder_open,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Select Your Image',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: Constants.topics
                                .map(
                                  (element) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(element)) {
                                          selectedTopics.remove(element);
                                        } else {
                                          selectedTopics.add(element);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(element),
                                        backgroundColor:
                                            selectedTopics.contains(element)
                                                ? AppPallete.gradient1
                                                : AppPallete.backgroundColor,
                                        side: selectedTopics.contains(element)
                                            ? null
                                            : const BorderSide(
                                                color: AppPallete.borderColor,
                                              ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlogEditor(
                          controller: _titleController,
                          hintText: 'Blog title',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlogEditor(
                          controller: _contentContorller,
                          hintText: 'Blog content',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
