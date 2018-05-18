
The goal of this exercise is to make the text content of the TODO item editable.

You should change the text component from having this type:
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m ()
```
to having this type:
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
```
and to integrate this change into your existing `todoItem` widget.

The text will be changed when the text input is focused and the user presses the Enter key.
The text will be stripped of whitespace at that point.
If the resulting text is non-empty, the `Event t (Text -> Text)` will fire.
Otherwise the second `Event` will fire, which signals that the item should be removed.

You should open
`~/reflex-workshop/code/src/Todo/Exercise/Item.hs `
and make the changes required to make this happen.
