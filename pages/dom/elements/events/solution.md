```haskell
eventsSolution :: MonadWidget t m
               => Dynamic t Bool
               -> m a
               -> m (Event t ())
eventsSolution dIn w = do





  pure never
```
=====
We'll start by adding the usual pieces to the page ...
=====
```haskell
eventsSolution :: MonadWidget t m
               => Dynamic t Bool
               -> m a
               -> m (Event t ())
eventsSolution dIn w = do
  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn
    attrs = "class" =: "text-uppercase"
  _      <- elDynAttr  "div" (pure attrs <> dAttrs) $
    w
  pure never
```
=====
... but we're need to get hold of an `Event` when the `div` is clicked.
=====
```haskell
eventsSolution :: MonadWidget t m
               => Dynamic t Bool
               -> m a
               -> m (Event t ())
eventsSolution dIn w = do
  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn
    attrs = "class" =: "text-uppercase"
  (e, _) <- elDynAttr' "div" (pure attrs <> dAttrs) $
    w
  pure never
```
=====
We pull out the `El` ...
=====
```haskell
eventsSolution :: MonadWidget t m
               => Dynamic t Bool
               -> m a
               -> m (Event t ())
eventsSolution dIn w = do
  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn
    attrs = "class" =: "text-uppercase"
  (e, _) <- elDynAttr' "div" (pure attrs <> dAttrs) $
    w
  pure $ domEvent Click e
```
=====
... and get hold of an `Event` that fires when we click on the `div`.
