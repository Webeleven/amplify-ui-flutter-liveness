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
