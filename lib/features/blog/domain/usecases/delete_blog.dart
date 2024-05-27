import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteBlog extends UseCase<void, DeleteBlogParams> {
  final BlogRepository blogRepository;
  DeleteBlog(this.blogRepository);

  @override
  Future<Either<Failure, void>> call(DeleteBlogParams params) async {
    return await blogRepository.deleteBlog(
      id: params.id,
    );
  }
}

class DeleteBlogParams {
  final String id;

  DeleteBlogParams({
    required this.id,
  });
}
