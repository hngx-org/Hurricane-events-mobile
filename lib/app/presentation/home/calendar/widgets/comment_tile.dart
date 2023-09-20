import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/comment_model.dart';

class CommentTile extends StatelessWidget {
  final CommentModel? comment;
  const CommentTile({super.key, this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    // TODO: uncomment background Image - removed to avoid console error
                    // backgroundImage: NetworkImage(comment?.avatar ?? ''),
                    child: comment?.avatar == null
                        ? Center(
                            child: Text(
                              comment?.fullName[0] ?? 'U',
                              style: context.body2.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const Gap(30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment?.fullName ?? 'Name',
                        style: context.body2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      10.height,
                      Text(
                        comment?.comment ?? 'Comment',
                        style: context.body2.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      comment?.image == null
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 40,
                              child: Center(
                                child: Image.network(
                                  comment?.image ?? 'Image',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.black,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 80,
                child: Text(
                  '${comment?.duration ?? 'X'} ago',
                  style: context.body2.copyWith(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
