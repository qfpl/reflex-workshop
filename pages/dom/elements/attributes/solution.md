```haskell
attributesSolution :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesSolution dIn w =





      w
```
=====
Again, we first want to wrap our widget up in a `div` ...
=====
```haskell
attributesSolution :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesSolution dIn w =
  let

    attrs = "class" =: "text-uppercase"
  in
    elAttr    "div"       attrs $
      w
```
=====
... which adds the `text-uppercase` class as an attribute.
=====
```haskell
attributesSolution :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesSolution dIn w =
  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn

  in
    elDynAttr "div"                dAttrs  $
      w
```
=====
We can use the `bool` function from `Data.Bool` and the `(=:)` helper operator to help create the necessary `Dynamic t (Map Text Text)`.
=====
```haskell
attributesSolution :: MonadWidget t m
                   => Dynamic t Bool
                   -> m a
                   -> m a
attributesSolution dIn w =
  let
    dAttrs = bool mempty ("hidden" =: "") <$> dIn
    attrs = "class" =: "text-uppercase"
  in
    elDynAttr "div" (pure attrs <> dAttrs) $
      w
```
=====
We can combine these with the `Semigroup` instance for `Dynamic`.
  
