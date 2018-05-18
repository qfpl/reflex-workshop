We are going to extend on the previous exercise in 
`~/reflex-workshop/code/src/Todo/Exercise/List.hs`
to add the ability to add new TODO items to the list.

First we'll need a widget that provides a text input, and fires an `Event` whenever the user presses Enter and the text is not empty after trimming.
The widget should clear its text after the user presses Enter.

You should write:
```haskell
addItem :: MonadWidget t m
        => m (Event t TodoItem)
```
to do this.

Once you have done that, you should extend `todoListExercise`.
It should include the `addItem` widget, and make use of the output from `addItem` to add items to our list.
