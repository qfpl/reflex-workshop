You should open
`~/reflex-workshop/code/src/Todo/Exercise/List.hs `
and copy your code from `todoListExercise` into `todoListModelExercise`:
```haskell
todoListModelExercise :: MonadWidget t m
                      => [TodoItem]
                      -> m (Dynamic t [TodoItem])
```

The goal is to return a `Dynamic` which tracks the changes to the list of TODO items over the life of the application. 

This will be used to display the completed items beside the widget.
