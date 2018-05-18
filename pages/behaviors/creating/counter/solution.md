```haskell
counterSolution :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Behavior t Int, Event t Int)
counterSolution eFn = mdo


  pure (_, _)
```
=====
If we had the `Event t Int` we could use `hold` to create the `Behavior t Int`, 
and if we had the `Behavior t Int`, we could sample it with the `Event t (Int -> Int)` and combine the two to create the `Event t Int`.
=====
```haskell
counterSolution :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Behavior t Int, Event t Int)
counterSolution eFn = mdo
  let e = flip ($) <$> b <@> eFn
  b <- hold 0 e
  pure (b, e)
```
=====
So we do that.
=====
```haskell
counterSolution :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Behavior t Int, Event t Int)
counterSolution eFn = mdo
  let e = (&) <$> b <@> eFn
  b <- hold 0 e
  pure (b, e)
```
=====
We can use `(&)` from `Data.Function` if we want to avoid the flip.
