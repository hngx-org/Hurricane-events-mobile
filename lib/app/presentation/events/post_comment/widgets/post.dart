import 'package:flutter/material.dart';
import 'package:hurricane_events/component/constants/color.dart';
import 'package:hurricane_events/component/utils/extensions.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.comment, required this.name}) : super(key: key);

  final String comment;
  final String name;
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1,color: AppColors.designGrey),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
            children: [
              Image.asset("assets/images/img_person1.png",width: 20),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(widget.name), const Text("Comment")],
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      widget.comment,
                      style: context.body2.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 20,)
        ],
      ),
    );
  }
}
