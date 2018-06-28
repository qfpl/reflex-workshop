The goal of this exercise is to display a list of TODO items.

You will be using your `todoItem` function from the previous exercises to display the individual items.

```haskell
todoListExercise :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListExercise items = 
  pure ()
```

to make this happen.

We will handle adding and removing things from the collection later on.
