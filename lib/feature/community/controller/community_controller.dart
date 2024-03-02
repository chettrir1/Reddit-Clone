import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/failure.dart';
import 'package:reddit_clone/core/providers/storage_repository_provider.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/feature/auth/controller/auth_controller.dart';
import 'package:reddit_clone/feature/community/repository/community_repository.dart';
import 'package:reddit_clone/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) =>
        CommunityController(
            communityRepository: ref.watch(communityRepositoryProvider),
            ref: ref,
            storageRepository: ref.watch(storageRepositoryProvider)));

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getCommunityByName(name);
});

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.searchCommunity(query);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? "";
    CommunityModel model = CommunityModel(
      id: name,
      name: name,
      banner: AssetsConstants.bannerDefault,
      avatar: AssetsConstants.avatarDefault,
      members: [uid],
      mods: [uid],
    );
    final response = await _communityRepository.createCommunity(model);
    state = false;
    response.fold((error) => showSnackBar(context, error.message), (r) {
      showSnackBar(context, "Community successfully created!");
      Routemaster.of(context).pop();
    });
  }

  Stream<List<CommunityModel>> getUserCommunities() {
    final uid = _ref.read(userProvider)?.uid ?? "";
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<CommunityModel> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

  void editCommunity({
    required File? profileFile,
    required File? bannerFile,
    required BuildContext context,
    required CommunityModel communityModel,
  }) async {
    state = true;
    if (profileFile != null) {
      final response = await _storageRepository.storeFile(
          path: 'communities/profile',
          id: communityModel.name,
          file: profileFile);
      response.fold((l) => showSnackBar(context, l.message),
          (r) => communityModel = communityModel.copyWith(avatar: r));
    }
    if (bannerFile != null) {
      final response = await _storageRepository.storeFile(
          path: 'communities/banner',
          id: communityModel.name,
          file: bannerFile);
      response.fold((l) => showSnackBar(context, l.message),
          (r) => communityModel = communityModel.copyWith(banner: r));
    }
    final response = await _communityRepository.editCommunity(communityModel);
    state = false;
    response.fold((l) => showSnackBar(context, l.message),
        (r) => Routemaster.of(context).pop());
  }

  Stream<List<CommunityModel>> searchCommunity(String query) {
    return _communityRepository.searchCommunity(query);
  }

  void joinCommunity(
      CommunityModel communityModel, BuildContext context) async {
    final user = _ref.read(userProvider);
    Either<Failure, void> res;
    if (communityModel.members.contains(user?.uid)) {
      res = await _communityRepository.leaveCommunity(
          communityModel.name, user?.uid ?? "");
    } else {
      res = await _communityRepository.joinCommunity(
          communityModel.name, user?.uid ?? "");
    }
    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (communityModel.members.contains(user?.uid)) {
        showSnackBar(context, "Community left successfully!");
      } else {
        showSnackBar(context, "Community joined successfully!");
      }
    });
  }

  void addMods(
      String communityName, List<String> uids, BuildContext context) async {
    final result = await _communityRepository.addMods(communityName, uids);
    result.fold((l) => showSnackBar(context, l.message),
        (r) => Routemaster.of(context).pop());
  }
}
