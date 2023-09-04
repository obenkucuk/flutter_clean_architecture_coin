import 'package:flutter/material.dart';

class ListTitles extends StatelessWidget {
  const ListTitles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Name / Vol',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              'Last Price',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              '24h Change',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
