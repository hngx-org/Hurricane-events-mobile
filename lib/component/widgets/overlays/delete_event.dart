import 'package:flutter/material.dart';
import 'package:hurricane_events/app/presentation/home/my_group/provider/my_group_provider.dart';
import 'package:hurricane_events/app/router/base_navigator.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';
import 'package:hurricane_events/domain/providers/events_provider.dart';
import 'package:provider/provider.dart';

class AppOverlays {
  static dynamic showDeleteDialog(
    BuildContext context,
    String eventId,
    String eventName,
  ) async {
    final s = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          titlePadding: const EdgeInsets.only(
            left: 24,
            top: 20,
          ),
          title: Text(
            "Delete Event",
            style: context.headline2,
          ),
          content: Text(
            "$eventName will be deleted. This action is irreversible, are you sure?",
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          actions: [
            InkWell(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: () {
                BaseNavigator.pop();
              },
              child: Text(
                "Cancel",
                style: context.headline2,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: () async {
                final s = await context.read<EventProvider>().deleteEvent(eventId: eventId);
                if (s == true) {
                  return BaseNavigator.pop(true);
                }
              },
              child: Text(
                "Delete",
                style: context.headline2.copyWith(
                  color: AppColors.designRed,
                ),
              ),
            )
          ],
          actionsPadding: const EdgeInsets.only(
            bottom: 20,
            right: 24,
          ),
        );
      },
    );

    if (s != null) {
      return s;
    }

    return null;
  }

  static dynamic showDeleteGroupDialog(
    BuildContext context,
    String groupId,
    String groupName,
  ) async {
    final s = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          titlePadding: const EdgeInsets.only(
            left: 24,
            top: 20,
          ),
          title: Text(
            "Delete Group",
            style: context.headline2,
          ),
          content: Text(
            "$groupName will be deleted. This action is irreversible, are you sure?",
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          actions: [
            InkWell(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: () {
                BaseNavigator.pop();
              },
              child: Text(
                "Cancel",
                style: context.headline2,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              onTap: () async {
                final s = await context.read<MyGroupProvider>().deleteGroup(
                      groupId: groupId,
                    );
                if (s == true) {
                  return BaseNavigator.pop(true);
                }
              },
              child: Text(
                "Delete",
                style: context.headline2.copyWith(
                  color: AppColors.designRed,
                ),
              ),
            )
          ],
          actionsPadding: const EdgeInsets.only(
            bottom: 20,
            right: 24,
          ),
        );
      },
    );

    if (s != null) {
      return s;
    }

    return null;
  }
}
