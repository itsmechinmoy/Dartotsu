import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage({
  required String? imageUrl,
  BoxFit? fit,
  double? width,
  double? height,
  Widget Function(BuildContext, String)? placeholder,
  Widget Function(BuildContext, String, Object)? errorWidget,
}) {
  if ((imageUrl == null || imageUrl.isEmpty)) {
    if (placeholder != null ){
      return SizedBox(
        width: width,
        height: height,
        child: Container(),
      );
    }
    return Icon(Icons.image_not_supported, weight: width ?? 24);
  }
  return CachedNetworkImage(
    filterQuality: FilterQuality.high,
    imageUrl: imageUrl,
    fit: fit,
    width: width,
    height: height,
    placeholder: placeholder ?? (context, url) => const SizedBox.shrink(),
    errorWidget:
        errorWidget ?? (context, url, error) => const SizedBox.shrink(),
  );
}
