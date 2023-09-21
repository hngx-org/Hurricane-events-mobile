import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/data/models/events/event_mock_up.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatelessWidget {
  final Comment? comment;

  const CommentTile({
    super.key,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      width: context.fullWidth,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              if (comment?.userImage != null) {
                return CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    comment?.image ?? '',
                  ),
                  radius: 15,
                );
              }
              return CircleAvatar(
                radius: 15,
                child: Center(
                  child: Text(
                    comment?.userName?[0] ?? 'U',
                    style: context.body2.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
          12.width,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment?.userName ?? 'Name',
                  style: context.body2.copyWith(
                    fontSize: 12,
                  ),
                ),
                10.height,
                Text(
                  comment?.comment ?? 'comment',
                  style: context.body2.copyWith(
                    fontSize: 14,
                  ),
                ),
                Builder(
                  builder: (_) {
                    if (comment?.hasImage == null || comment?.hasImage == false) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        8.height,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: comment?.image ?? "",
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Text(
            timeago.format(comment?.createdAt ?? DateTime.now()),
            style: context.body2.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
