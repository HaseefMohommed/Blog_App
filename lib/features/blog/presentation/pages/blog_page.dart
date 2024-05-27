import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static blogPageRoute() =>
      MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                AddNewBlogPage.addNewBlogRoute(),
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          BlocListener<AppUserCubit, AppUserState>(
            listener: (context, state) {
              if (state is AppUserInitial) {
                Navigator.of(context).pushAndRemoveUntil(
                  LogInPage.logInRoute(),
                  (route) => false,
                );
              }
            },
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'SignOut') {
                  context.read<AuthBloc>().add(AuthSignOut());
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'SignOut',
                  child: Text('Sign Out'),
                ),
              ],
              child: const CircleAvatar(
                backgroundColor: AppPallete.gradient3,
                child: Text('H'),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
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
                    color: Colors.red.shade600,
                    height: 200,
                    margin: const EdgeInsets.all(16).copyWith(
                      bottom: 4,
                    ),
                  ),
                  child: BlogCard(
                    blog: blog,
                    color: index % 2 == 0
                        ? AppPallete.gradient1
                        : AppPallete.gradient2,
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
