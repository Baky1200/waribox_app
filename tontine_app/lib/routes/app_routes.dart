import 'package:flutter/material.dart';
import '../screens/tontine/create_tontine_screen.dart';
import '../screens/tontine/tontine_detail_screen.dart';
import '../screens/tontine/join_tontine_screen.dart';
import '../screens/tontine/invite_members_screen.dart';


class AppRoutes {
  static const String createTontine = '/create-tontine';
  static const String tontineDetail = '/tontine-detail';
  static const String joinTontine = '/join-tontine';
  static const String inviteMembers = '/invite-members';

  static Map<String, WidgetBuilder> routes = {
    createTontine: (context) => CreateTontineScreen(),
    tontineDetail: (context) => TontineDetailScreen(),
    joinTontine: (context) => JoinTontineScreen(),
    inviteMembers: (context) => InviteMembersScreen(tontineCode: ''), // Remplacer dynamiquement plus tard
  };
}
