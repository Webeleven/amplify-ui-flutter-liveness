import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FaceLivenessDetector extends StatefulWidget {
  final String sessionId;
  final String region;
  final VoidCallback? onComplete;
  final ValueChanged<String>? onError;
  final ChallengeOptions? challengeOptions;

  const FaceLivenessDetector({
    super.key,
    required this.sessionId,
    required this.region,
    this.onComplete,
    this.onError,
    this.challengeOptions,
  });

  @override
  State<FaceLivenessDetector> createState() => _FaceLivenessDetectorState();
}

class _FaceLivenessDetectorState extends State<FaceLivenessDetector> {
  final _eventChannel = EventChannel('face_liveness_event');

  @override
  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen((event) {
      if (event == 'complete') {
        widget.onComplete?.call();
      } else {
        widget.onError?.call(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return const SizedBox();

    if (Platform.isIOS) {
      return UiKitView(
        viewType: 'face_liveness_view',
        layoutDirection: TextDirection.ltr,
        creationParams: {
          'sessionId': widget.sessionId,
          'region': widget.region,
          if (widget.challengeOptions != null)
            'challengeOptions': widget.challengeOptions!.toMap(),
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return AndroidView(
      viewType: 'face_liveness_view',
      layoutDirection: TextDirection.ltr,
      creationParams: {
        'sessionId': widget.sessionId,
        'region': widget.region,
        if (widget.challengeOptions != null)
          'challengeOptions': widget.challengeOptions!.toMap(),
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

enum FaceLivenessCamera {
  front,
  back,
}

class FaceMovementChallengeOptions {
  final FaceLivenessCamera camera;

  const FaceMovementChallengeOptions({
    this.camera = FaceLivenessCamera.front,
  });

  Map<String, Object> toMap() {
    return {
      'camera': camera.name,
    };
  }
}

class ChallengeOptions {
  final FaceMovementChallengeOptions? faceMovement;

  const ChallengeOptions({
    this.faceMovement,
  });

  Map<String, Object> toMap() {
    final data = <String, Object>{};
    if (faceMovement != null) {
      data['faceMovement'] = faceMovement!.toMap();
    }
    return data;
  }
}
