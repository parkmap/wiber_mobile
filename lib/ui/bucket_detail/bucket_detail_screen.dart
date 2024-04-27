import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wiber_mobile/models/bucket/bucket.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';
import 'components/body.dart';

@RoutePage()
class BucketDetailScreen extends StatelessWidget {
  final WiberSpace space;
  final Bucket item;
  final VoidCallback onDelete;

  const BucketDetailScreen({
    Key? key,
    required this.space,
    required this.item,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Body(
          space: space,
          item: item,
          onDelete: onDelete,
        ),
      ),
    );
  }
}
