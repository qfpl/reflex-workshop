```haskell
todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = do
  let
    m = Map.fromList . zip [0..] $ items


  pure ()
```
=====
We start by turning the list of items into a `Map` of items
=====
```haskell
todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = do
  let
    m = Map.fromList . zip [0..] $ items
  _ <- listHoldWithKey m never $ \_ item -> do
    _
  pure ()
```
=====
Then we feed that `Map` into `listHoldWithKey` ...
=====
```haskell
todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = do
  let
    m = Map.fromList . zip [0..] $ items
  _ <- listHoldWithKey m never $ \_ item -> do
    todoItem item
  pure ()
```
=====
... and display the item.
=====
```haskell
todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = do
  let
    m = Map.fromList . zip [0..] $ items
  void . listHoldWithKey m never $
    const todoItem
  
```
=====
We can tidy this up a little if we like.
  
