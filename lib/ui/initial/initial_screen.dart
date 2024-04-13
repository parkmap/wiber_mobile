import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Body()),
    );
  }
}
