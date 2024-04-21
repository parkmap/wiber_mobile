import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'package:wiber_mobile/widgets/custom_app_bar_with_back_button.dart';
import 'components/body.dart';

@RoutePage()
class BucketScreen extends StatelessWidget {
  final WiberSpace item;
  const BucketScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Body(item: item),
      ),
    );
  }
}
