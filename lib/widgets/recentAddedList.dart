import 'package:flutter/material.dart';
import 'BookItem.dart';

class recentAddedList extends StatelessWidget {
  const recentAddedList({super.key});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          BookItem(
            title: 'No Longer Human',
            author: 'Osamu Dazai',
            coverUrl:
            'https://i.pinimg.com/736x/d7/2b/21/d72b2135849f6a65a60a3afbe994551b.jpg',
            price: '79,00 SAR',
          ),
          SizedBox(width: 12),
          BookItem(
            title: 'The Stranger',
            author: 'Albert Camus',
            coverUrl:
            'https://i.pinimg.com/736x/89/46/6a/89466afd3864116d3c6c59b620b116ab.jpg',
            price: '53,00 SAR',
          ),
          SizedBox(width: 12),
          BookItem(
            title: 'The Bell Jar',
            author: 'Sylvia Plath',
            coverUrl:
            'https://i.pinimg.com/1200x/1b/ae/22/1bae226df7df268d2ccb699ef134a811.jpg',
            price: '38,00 SAR',
          ),
        ],
      ),
    );
  }
}
