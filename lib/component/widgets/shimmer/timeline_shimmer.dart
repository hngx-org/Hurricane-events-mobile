import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class TimelineShimmer extends StatelessWidget {
  final int? list;
  const TimelineShimmer({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list ?? 10,
      itemBuilder: (context, index) {
        var size = MediaQuery.of(context).size;
        return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(.7),
          highlightColor: Colors.grey.withOpacity(0.1),
          enabled: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              16.width,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: 58,
                        height: 10.0,
                      ),
                      6.height,
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: 30,
                        height: 10.0,
                      ),
                      6.height,
                      Container(
                        width: size.width * 0.4,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: size.width * 0.2,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: size.width * 0.2,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: size.width * 0.2,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
