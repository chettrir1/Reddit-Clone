import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/feature/community/controller/community_controller.dart';
import 'package:reddit_clone/theme/palette.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref.read(communityControllerProvider.notifier).createCommunity(
          communityNameController.text.trim(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a community"),
      ),
      body: (isLoading)
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Community Name")),
                  const SizedBox(height: 10),
                  TextField(
                    controller: communityNameController,
                    decoration: const InputDecoration(
                        hintText: 'r/Community_name',
                        filled: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18)),
                    maxLength: 21,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.blueColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Create Community',
                      style: TextStyle(fontSize: 16, color: Palette.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
