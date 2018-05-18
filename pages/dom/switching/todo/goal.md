We are going to continue to edit the TODO item example.

You should change the behavior of the text component:
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
```

It should start by displaying the text in a `div`, as it did before we introduced the text input.
If the `div` is double clicked, the `div` should be swapped out for a text input.
If the item is not removed, the text input should turn back into a div when the editing is completed.

Try to do this with a `Workflow` if you can.

You should open
`~/reflex-workshop/code/src/Todo/Exercise/Item.hs `
and make the changes required to make this happen.

