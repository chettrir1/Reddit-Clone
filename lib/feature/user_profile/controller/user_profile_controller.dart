import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/providers/storage_repository_provider.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/feature/auth/controller/auth_controller.dart';
import 'package:reddit_clone/feature/user_profile/repository/user_profile_repository.dart';
import 'package:reddit_clone/models/user_model.dart';
import 'package:routemaster/routemaster.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) =>
        UserProfileController(
            userProfileRepository: ref.watch(userProfileRepositoryProvider),
            ref: ref,
            storageRepository: ref.watch(storageRepositoryProvider)));

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editUserProfile({
    required File? profileFile,
    required File? bannerFile,
    required String name,
    required BuildContext context,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;

    if (profileFile != null) {
      final response = await _storageRepository.storeFile(
          path: 'users/profile', id: user.uid, file: profileFile);
      response.fold((l) => showSnackBar(context, l.message),
          (r) => user = user.copyWith(profilePic: r));
    }
    if (bannerFile != null) {
      final response = await _storageRepository.storeFile(
          path: 'users/banner', id: user.uid, file: bannerFile);
      response.fold((l) => showSnackBar(context, l.message),
          (r) => user = user.copyWith(banner: r));
    }
    user = user.copyWith(name: name);
    final response = await _userProfileRepository.editProfile(user);
    state = false;
    response.fold((l) => showSnackBar(context, l.message), (r) {
      _ref.read(userProvider.notifier).update((state) => user);
      Routemaster.of(context).pop();
    });
  }
}
