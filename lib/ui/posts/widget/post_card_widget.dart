import 'package:flutter/material.dart';
import 'package:simple_crud_bloc/data/models/post_model.dart';

import '../../../utils/res_color.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel data;
  final VoidCallback? onTap;

  const PostCardWidget(
      {Key? key, required this.data, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        elevation: 4,
        color: Colors.white,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          splashColor: ResColor.colorPrimary,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(data.title ?? '-', style: const TextStyle(
                  color: ResColor.greyTextColor,
                  fontSize: 14,
                ),),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Text(data.body?? '-', style: const TextStyle(
                  color: ResColor.greyTextColor,
                  fontSize: 14,
                ),),
                const SizedBox(height: 8,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
