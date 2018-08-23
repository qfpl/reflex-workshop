You should copy your code from `todoListExercise` into `todoListModelExercise`:
```haskell
todoListModelExercise :: MonadWidget t m
                      => [TodoItem]
                      -> m (Dynamic t [TodoItem])
```

The goal is to return a `Dynamic` which tracks the changes to the list of TODO items over the life of the application. 

This will be used to display the completed items beside the widget.

Once you are done, you can also write
```haskell
todoListExercise :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListExercise = 
  void . todoListModelExercise
```
to cut down on duplication.
