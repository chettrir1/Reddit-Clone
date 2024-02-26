import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/feature/community/controller/community_controller.dart';
import 'package:reddit_clone/theme/palette.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;

  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
        data: (community) => Scaffold(
              appBar: AppBar(
                title: const Text("Edit Community"),
                centerTitle: false,
                actions: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Palette.blueColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              body: Column(
                children: [
                  DottedBorder(
                      radius: const Radius.circular(4),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      color: Palette.darkModeAppTheme.textTheme.bodyMedium!.color!,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: (community.banner.isEmpty ||
                                community.banner ==
                                    AssetsConstants.bannerDefault)
                            ? const Center(
                                child: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                              ))
                            : Image.network(community.banner),
                      ))
                ],
              ),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
