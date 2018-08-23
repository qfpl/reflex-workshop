In this exercise we will start making a component for TODO items.

The first goal is to create a TODO item that:

- displays the text of the item
- has a button which can be pressed to indicate that the item should be removed

The second goal is to create a test harness for the item.
This test harness should create a sample TODO item and also display how many times the remove button has been pressed.

You can write your own counting function if you like, but there is a helper function for counting occurrences of `Event`s:
```haskell
count :: (Reflex t, MonadHold t m, MonadFix m, Num b) 
      => Event t a 
      -> m (Dynamic t b)
```

You should fill out these functions:

```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem ti = do
  pure never

todoExercise :: MonadWidget t m
             => TodoItem 
             -> m ()
todoExercise ti = do
  pure ()
```
using this data structure from `Common.Todo`:
```haskell
data TodoItem =
  TodoItem {
    _todoItem_complete :: Bool
  , _todoItem_text     :: Text
  }
```

You don't have to get the spacing and layout right - we'll cover bits of that when we go through the solution.
