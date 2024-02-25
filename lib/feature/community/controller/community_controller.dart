import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/feature/auth/controller/auth_controller.dart';
import 'package:reddit_clone/feature/community/repository/community_repository.dart';
import 'package:reddit_clone/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>(
        (ref) => CommunityController(
              communityRepository: ref.watch(communityRepositoryProvider),
              ref: ref,
            ));

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;

  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
  })  : _communityRepository = communityRepository,
        _ref = ref,
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
}
