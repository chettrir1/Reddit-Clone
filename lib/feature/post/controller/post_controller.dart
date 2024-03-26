import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/providers/storage_repository_provider.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/feature/auth/controller/auth_controller.dart';
import 'package:reddit_clone/feature/post/repository/post_repository.dart';
import 'package:reddit_clone/models/community_model.dart';
import 'package:reddit_clone/models/post_model.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final postControllerProvider =
StateNotifierProvider<PostController, bool>((ref) =>
    PostController(
        postRepository: ref.watch(postRepositoryProvider),
        ref: ref,
        storageRepository: ref.watch(storageRepositoryProvider)));

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  PostController({
    required PostRepository postRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _postRepository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void shareTextPost({
    required BuildContext context,
    required String title,
    required CommunityModel selectedCommunity,
    required String description,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(userProvider);

    final PostModel postModel = PostModel(
        id: postId,
        title: title,
        communityName: selectedCommunity.name,
        communityProfilePic: selectedCommunity.avatar,
        upvotes: [],
        downvotes: [],
        commentCount: 0,
        username: user!.name,
        uid: user.uid,
        type: "text",
        createdAt: DateTime.now(),
        awards: [],
        description: description);

    final response = await _postRepository.addPost(postModel);
    state = false;
    response.fold((error) => showSnackBar(context, error.message), (r) {
      showSnackBar(context, "Posted successfully!");
      Routemaster.of(context).pop();
    });
  }

  void shareLinktPost({
    required BuildContext context,
    required String title,
    required CommunityModel selectedCommunity,
    required String link,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(userProvider);

    final PostModel postModel = PostModel(
        id: postId,
        title: title,
        communityName: selectedCommunity.name,
        communityProfilePic: selectedCommunity.avatar,
        upvotes: [],
        downvotes: [],
        commentCount: 0,
        username: user!.name,
        uid: user.uid,
        type: "link",
        createdAt: DateTime.now(),
        awards: [],
        link: link);

    final response = await _postRepository.addPost(postModel);
    state = false;
    response.fold((error) => showSnackBar(context, error.message), (r) {
      showSnackBar(context, "Posted successfully!");
      Routemaster.of(context).pop();
    });
  }

  void shareImagePost({
    required BuildContext context,
    required String title,
    required CommunityModel selectedCommunity,
    required File? file,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(userProvider);
    final imageRes = await _storageRepository.storeFile(
        path: 'posts/${selectedCommunity.name}', id: postId, file: file);

    imageRes.fold((error) => showSnackBar(context, error.message), (r) async {
      final PostModel postModel = PostModel(
          id: postId,
          title: title,
          communityName: selectedCommunity.name,
          communityProfilePic: selectedCommunity.avatar,
          upvotes: [],
          downvotes: [],
          commentCount: 0,
          username: user!.name,
          uid: user.uid,
          type: "text",
          createdAt: DateTime.now(),
          awards: [],
          link: r);

      final response = await _postRepository.addPost(postModel);
      state = false;
      response.fold((error) => showSnackBar(context, error.message), (r) {
        showSnackBar(context, "Posted successfully!");
        Routemaster.of(context).pop();
      });
    });
  }
}
