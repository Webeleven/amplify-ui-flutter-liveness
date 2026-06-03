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
