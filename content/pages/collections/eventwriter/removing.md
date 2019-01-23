We are going to extend on the previous exercise to use `EventWriterT` to pass the remove `Event`s up through the collection handling code.

Part of your code should look like this:
```haskell
  (dmd, eRemoves) <- runEventWriterT . listHoldWithKey m eListChange $ \k item -> do
    ...

  let
    eListChange =
      leftmost [eRemoves, eInsert]
    dItems =
      fmap Map.elems .
      joinDynThroughMap $
      dmd

  pure dItems
```

You should make the changes to `todoListModelExercise` required to make this happen.
