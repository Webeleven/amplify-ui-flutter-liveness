## 0.0.4

* iOS: map `accessDenied` and `cameraPermissionDenied` to the same stable codes
  Android already emits, and resolve a stable member name for every other
  `FaceLivenessDetectionError` in the fallback (`error:<name>:<message>`, using the
  SDK's fixed English `message` instead of the locale-dependent
  `localizedDescription`). Previously every unmapped iOS error stringified to the
  same struct type name, so consumers (e.g. Sentry grouping) could not tell a
  credentials outage from a benign timeout.
* Dart: cancel the `face_liveness_event` subscription in `dispose`. The previous
  code never cancelled, so the last detector's callbacks stayed subscribed to the
  broadcast channel for the app's lifetime and late native events (teardown
  errors) still reached widgets that were already gone.

## 0.0.3

* iOS: bump the liveness SDK fork to `1.4.4-webeleven.2`, which adds two PR-review
  hardenings on top of 0.0.2: deliver the final single frame on the main queue (outside the
  serial lock) and only call `finishWriting` when the writer status is `.writing`. Uses a
  fresh immutable tag (the previous `1.4.4-webeleven.1` tag had been moved, which broke SPM
  resolution).

## 0.0.2

* iOS: fix fatal `NSInternalInconsistencyException` ("Must start a session ... before
  appending pixel buffers") crash originating in the Amplify liveness SDK's
  `VideoChunker`. The iOS dependency now points at the Webeleven fork of
  `amplify-ui-swift-liveness` (tag `1.4.4-webeleven.1`), which serializes the
  `AVAssetWriter` start/finish/consume lifecycle to close an append-after-finish data
  race. Upstream 1.4.4 is still affected. Revert to the upstream package once the fix
  lands there.

## 0.0.1

* TODO: Describe initial release.
