import 'package:blog_app/core/common/widgets/language_dialog.dart';
import 'package:blog_app/features/blog/presentation/widgets/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static blogPageRoute() =>
      MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        _scaffoldKey.currentState?.openDrawer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const LanguageDialog(),
              );
            },
          ),
        ],
      ),
      drawer: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState!.closeDrawer();
        },
        child: ProfileDrawer(scaffoldKey: _scaffoldKey),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.failure);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Dismissible(
                  key: Key(blog.id),
                  onDismissed: (direction) {
                    context
                        .read<BlogBloc>()
                        .add(BlogRemoveBlog(blogId: blog.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${blog.title} dismissed')),
                    );
                    Navigator.push(context, BlogPage.blogPageRoute());
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: AppPalette.errorColor,
                    height: 200,
                    margin: const EdgeInsets.all(16).copyWith(
                      bottom: 4,
                    ),
                  ),
                  child: BlogCard(
                    blog: blog,
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                iconSize: 30,
                color: _selectedIndex == 0 ? AppPalette.greyShade2 : null,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: const Icon(Icons.person),
                iconSize: 30,
                color: _selectedIndex == 1 ? AppPalette.greyShade2 : null,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  _onItemTapped(_selectedIndex);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            AddNewBlogPage.addNewBlogRoute(),
          );
        },
        elevation: 3.0,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
