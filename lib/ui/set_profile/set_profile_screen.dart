import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wiber_mobile/widgets/custom_app_bar_with_back_button.dart';
import 'components/body.dart';

@RoutePage()
class SetProfileScreen extends StatelessWidget {
  const SetProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithBackButton(),
      body: const SafeArea(child: Body()),
    );
  }
}
