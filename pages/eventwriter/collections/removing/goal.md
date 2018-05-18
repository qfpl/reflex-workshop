We are going to extend on the previous exercise in 
`~/reflex-workshop/code/src/Todo/Exercise/List.hs`
to use `EventWriterT` to pass the remove `Event`s up through the collection handling code.

Part of your code should look like this:
```haskell
  (dmd, eRemoves) <- runEventWriterT . listHoldWithKey m eListChange $ \k item -> do
    ...

  let
    eListChange = leftmost [eRemoves, eInsert]

  pure $ joinDynThroughMap dmd
```

You should open
`~/reflex-workshop/code/src/Todo/Exercise/List.hs `
and make the changes to `todoListModelExercise` required to make this happen.
