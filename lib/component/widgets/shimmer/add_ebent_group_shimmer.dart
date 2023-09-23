import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class AddEventGroupShimmer extends StatelessWidget {
  final int? list;
  const AddEventGroupShimmer({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: list ?? 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(.7),
          highlightColor: Colors.grey.withOpacity(0.1),
          enabled: true,
          child: Container(
            width: 80,
            height: 20,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return 12.width;
      },
    );
  }
}
