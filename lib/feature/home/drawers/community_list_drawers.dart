import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/constants/assets_constants.dart';
import 'package:reddit_clone/feature/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text("Create a Community"),
              leading: const Icon(Icons.add),
              onTap: () => navigateToCommunity(context),
            ),
            ref.watch(userCommunitiesProvider).when(
                data: (data) => Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final community = data[index];
                          return ListTile(
                            title: Text("r/${community.name}"),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(community.avatar ?? ""),
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader())
          ],
        ),
      ),
    );
  }
}
