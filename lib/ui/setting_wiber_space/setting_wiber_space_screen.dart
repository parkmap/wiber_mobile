import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

@RoutePage()
class SettingWiberSpaceScreen extends StatelessWidget {
  const SettingWiberSpaceScreen({
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
