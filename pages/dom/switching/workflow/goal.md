This is an extension of the previous exercise.

The goal is to alter that exercise so that it uses the `Workflow` machinery to manage the widgets and the switching between them.

You should open
`~/reflex-workshop/code/src/Workshop/DOM/Switching/Workflow/Exercise.hs `
and fill out this function:

```haskell
workflowExercise :: MonadWidget t m
                 => Event t ()
                 -> m (Dynamic t Int)
workflowExercise eChange = do
  pure (pure 0)
```

to make this happen.
