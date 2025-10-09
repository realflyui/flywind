import 'package:flutter/material.dart';

import '../core/style.dart';
import '../mixins/flex.dart';
import '../mixins/margin.dart';
import '../mixins/object.dart';
import '../mixins/padding.dart';
import '../mixins/position.dart';
import '../mixins/rounded.dart';
import '../mixins/size.dart';

/// A generic image widget with image-specific utilities
class FlyImage extends StatelessWidget
    with
        FlyPadding<FlyImage>,
        FlyMargin<FlyImage>,
        FlyRounded<FlyImage>,
        FlySize<FlyImage>,
        FlyFlex<FlyImage>,
        FlyPosition<FlyImage>,
        FlyObject<FlyImage> {
  FlyImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.imageProvider,
    this.fit = BoxFit.cover,
    this.onLoadingStateChange,
    this.loadingWidget,
    this.errorWidget,
    this.width,
    this.height,
    this.alignment,
    FlyStyle flyStyle = const FlyStyle(),
  }) : _flyStyle = flyStyle;

  // Image-specific properties
  final String? imageUrl;
  final String? assetPath;
  final ImageProvider? imageProvider;
  final BoxFit fit;
  final ValueChanged<bool>? onLoadingStateChange;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  // Styling properties
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  final FlyStyle _flyStyle;

  @override
  FlyStyle get flyStyle => _flyStyle;

  /// Override this to provide component-specific default styles
  @protected
  FlyStyle getDefaultStyle(FlyStyle incomingStyle) => incomingStyle;

  @override
  Widget build(BuildContext context) {
    final resolvedImageProvider = _getImageProvider();

    if (resolvedImageProvider == null) {
      // If no image provider, return empty container
      return const SizedBox.shrink();
    }

    // Get the fit from style or fall back to the direct fit parameter
    final BoxFit resolvedFit = _getResolvedFit();

    // Get resolved width and height
    final double? resolvedWidth = _getResolvedWidth(context);
    final double? resolvedHeight = _getResolvedHeight(context);

    // Create the image widget
    Widget imageWidget = Image(
      image: resolvedImageProvider,
      width: resolvedWidth,
      height: resolvedHeight,
      fit: resolvedFit,
      alignment: alignment ?? Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? const SizedBox.shrink();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          onLoadingStateChange?.call(false);
          return child;
        }
        onLoadingStateChange?.call(true);
        return loadingWidget ?? child;
      },
    );

    // Apply size constraints using the FlySize mixin
    imageWidget = applySize(context, imageWidget);

    // Apply rounded corners if specified
    imageWidget = applyRounded(context, imageWidget);

    // Apply all other utilities using the existing mixin methods
    imageWidget = applyPadding(context, imageWidget);
    imageWidget = applyMargin(context, imageWidget);
    imageWidget = applyPosition(context, imageWidget);
    imageWidget = applyFlex(context, imageWidget);

    return imageWidget;
  }

  @override
  FlyImage Function(FlyStyle newStyle) get copyWith => (newStyle) {
    return FlyImage(
      key: key,
      imageUrl: imageUrl,
      assetPath: assetPath,
      imageProvider: imageProvider,
      fit: fit,
      onLoadingStateChange: onLoadingStateChange,
      loadingWidget: loadingWidget,
      errorWidget: errorWidget,
      width: width,
      height: height,
      alignment: alignment,
      flyStyle: newStyle,
    );
  };

  /// Get the appropriate image provider based on provided parameters
  ImageProvider? _getImageProvider() {
    if (imageProvider != null) {
      return imageProvider;
    } else if (imageUrl != null) {
      return NetworkImage(imageUrl!);
    } else if (assetPath != null) {
      return AssetImage(assetPath!);
    }
    return null;
  }

  /// Get the resolved BoxFit from style or fall back to direct fit parameter
  BoxFit _getResolvedFit() {
    // First check if object is set in the style
    if (flyStyle.object != null) {
      if (flyStyle.object is BoxFit) {
        return flyStyle.object as BoxFit;
      } else if (flyStyle.object is String) {
        return FlyObjectUtils.parseBoxFitFromString(flyStyle.object as String);
      }
    }

    // Fall back to the direct fit parameter
    return fit;
  }

  /// Get resolved width from style or fall back to direct width parameter
  double? _getResolvedWidth(BuildContext context) {
    // First check if width is set in the style
    if (flyStyle.w != null) {
      return FlySizeUtils.resolveWidth(context, flyStyle);
    }

    // Fall back to the direct width parameter
    return width;
  }

  /// Get resolved height from style or fall back to direct height parameter
  double? _getResolvedHeight(BuildContext context) {
    // First check if height is set in the style
    if (flyStyle.h != null) {
      return FlySizeUtils.resolveHeight(context, flyStyle);
    }

    // Fall back to the direct height parameter
    return height;
  }
}
