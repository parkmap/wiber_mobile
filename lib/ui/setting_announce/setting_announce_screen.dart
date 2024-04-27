import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'components/body.dart';

@RoutePage()
class SettingAnnounceScreen extends StatelessWidget {
  const SettingAnnounceScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
