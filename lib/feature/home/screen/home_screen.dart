import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/feature/auth/controller/auth_controller.dart';
import 'package:reddit_clone/feature/home/delegates/search_community_delegates.dart';
import 'package:reddit_clone/feature/home/drawers/community_list_drawers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegates(ref));
            },
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user?.profilePic ?? ""),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Text(user?.name ?? ""),
      ),
      drawer: const CommunityListDrawer(),
    );
  }
}
