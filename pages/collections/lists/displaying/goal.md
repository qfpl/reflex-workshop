The goal of this exercise is to display a list of TODO items.

You will be using your `todoItem` function from `~/reflex-workshop/code/src/Todo/Exercise/Item.hs` to display the individual items.

You should open
`~/reflex-workshop/code/src/Todo/Exercise/List.hs`
and fill out this function:

```haskell
todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = 
  pure ()
```

to make this happen.

We will handle adding and removing things from the collection later on.
