```haskell
fmapSolution :: (Reflex t, MonadHold t m)
             => Event t Int
             -> m (Behavior t Int)
fmapSolution eIn =
  _
```
=====
We're going to be turning an `Event` into a `Behavior`...
=====
```haskell
fmapSolution :: (Reflex t, MonadHold t m)
             => Event t Int
             -> m (Behavior t Int)
fmapSolution eIn =
  hold 0 eIn
```
=====
... so we use `hold`.

