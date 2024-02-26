import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;

  const ModToolsScreen({super.key, required this.name});

  void navigateEditCommunity(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mode Tools"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Add Moderators"),
            leading: const Icon(Icons.add_moderator),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Edit Community"),
            leading: const Icon(Icons.edit),
            onTap: () {
              navigateEditCommunity(context);
            },
          ),
        ],
      ),
    );
  }
}
