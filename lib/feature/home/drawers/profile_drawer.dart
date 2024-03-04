import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/feature/auth/controller/auth_controller.dart';
import 'package:reddit_clone/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logout(WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).logout();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(user?.profilePic ?? AssetsConstants.avatarDefault),
            radius: 70,
          ),
          const SizedBox(height: 10),
          Text(
            "u/${user?.name}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          const Divider(),
          ListTile(
            title: const Text("My Profile"),
            leading: const Icon(Icons.person),
            onTap: () => navigateToUserProfile(context, user?.uid ?? ""),
          ),
          ListTile(
            title: const Text("Logout"),
            leading: Icon(
              Icons.logout,
              color: Palette.redColor,
            ),
            onTap: () => logout(ref),
          ),
          Switch.adaptive(value: true, onChanged: (val) {})
        ]),
      ),
    );
  }
}
