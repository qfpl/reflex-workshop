In this exercise we're making a silly game that involves clicking a button as fast as you can.

The game cycles between two modes of operation.
There is a countdown that is displayed to indicate when the mode of operation is next going to change.

While the game is in the clicking mode, any clicks will add to the score.
While the game is in the waiting mode, any clicks will reset the score.

You will be given an `Event t Bool` that fires with `False` when the game is moving into waiting mode and fires with `True` when the game is moving into click mode.

You will also be given an `Event t ()` which fires when the button is clicked.

You should fill out this function:

```haskell
higherOrderExercise :: (Reflex t, MonadFix m, MonadHold t m)
                    => Event t Bool
                    -> Event t ()
                    -> m (Dynamic t Int)
higherOrderExercise eClickable eClick =
  pure (pure 0)
```

to make this happen.
