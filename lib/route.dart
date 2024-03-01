/*logged out*/
import 'package:flutter/material.dart';
import 'package:reddit_clone/feature/auth/screen/login_screen.dart';
import 'package:reddit_clone/feature/community/screen/add_mods_screen.dart';
import 'package:reddit_clone/feature/community/screen/community_screen.dart';
import 'package:reddit_clone/feature/community/screen/create_community_screen.dart';
import 'package:reddit_clone/feature/community/screen/edit_community_screen.dart';
import 'package:reddit_clone/feature/community/screen/mod_tools_screen.dart';
import 'package:reddit_clone/feature/home/screen/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

/*logged in*/

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
          child: CommunityScreen(
        name: route.pathParameters['name'] ?? "",
      )),
  '/mod-tools/:name': (route) => MaterialPage(
          child: ModToolsScreen(
        name: route.pathParameters['name'] ?? "",
      )),
  '/edit-community/:name': (route) => MaterialPage(
          child: EditCommunityScreen(
        name: route.pathParameters['name'] ?? "",
      )),
  '/add-mods/:name': (route) => MaterialPage(
          child: AddModsScreen(
        name: route.pathParameters['name'] ?? "",
      )),
});
