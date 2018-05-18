
The goal of this exercise is to add a checkbox to the TODO item to track the completion state of the item.

If the item is in the completed state, the `div` containing the text of the item should have the "completed" class added to it.

Your `todoItem` function should change from this type:
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
```
to this type:
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
```
and your test harness should report on the number of times each of these `Event`s fire.

You should open
`~/reflex-workshop/code/src/Todo/Exercise/Item.hs `
and make the changes required to make this happen.

If you spot ways to reduce duplication or increase modularity, go for it.
It might be helpful to reread the section on "Components" if you want to really push that.
