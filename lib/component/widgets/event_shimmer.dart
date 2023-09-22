import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class EventShimmer extends StatelessWidget {
  final int? list;
  const EventShimmer({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(.7),
              highlightColor: Colors.grey.withOpacity(0.1),
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24),
                child: Column(
                  children: [
                    Row(
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 11),
                                Container(
                                  width: context.fullWidth * 0.2,
                                  height: 17.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: context.fullWidth * 0.2,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: context.fullWidth * 0.2,
                                  height: 10.0,
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
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
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
                                  width: 100,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 50,
                                  height: 10.0,
                                ),
                                6.height,
                                Container(
                                  width: context.fullWidth * 0.6,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                16.height,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: Colors.white),
                    16.height,
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
