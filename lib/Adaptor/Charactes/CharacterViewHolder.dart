
import 'package:dantotsu/DataClass/Character.dart';
import 'package:flutter/material.dart';

import '../../Widgets/CachedNetworkImage.dart';

class CharacterViewHolder extends StatelessWidget {
  final character charInfo;

  const CharacterViewHolder({super.key, required this.charInfo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: cachedNetworkImage(
              imageUrl: charInfo.image ?? '',
              fit: BoxFit.cover,
              width: 108,
              height: 160,
              placeholder: (context, url) => Container(
                color: Colors.white12,
                width: 108,
                height: 160,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              charInfo.name ?? "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: theme.onSurface,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                charInfo.role ?? "",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.0,
                  color: theme.onSurface.withOpacity(0.58),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
