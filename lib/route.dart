/*logged out*/
import 'package:flutter/material.dart';
import 'package:reddit_clone/feature/auth/screen/login_screen.dart';
import 'package:reddit_clone/feature/community/screen/create_community_screen.dart';
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
});