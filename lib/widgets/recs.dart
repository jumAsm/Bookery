import 'package:flutter/material.dart';

class recsList extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;

  const recsList({
    required this.title,
    required this.author,
    required this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              coverUrl,
              width: 64,
              height: 86,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
