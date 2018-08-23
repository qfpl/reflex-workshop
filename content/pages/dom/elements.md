After adding text to the page, the next simplest thing we can do is to wrap an element around some other widget:
```haskell
el      :: DomBuilder t m 
        => Text 
        -> m a 
        -> m a
```

We can use that already:
```haskell
  el "div" $ 
    text "Testing text"
```

If things are going to change, we use `Dynamic`s to drive those changes.
That means we can create some state while still having the ability to trigger updates in the DOM.

For text that we want to update we have:
```haskell
dynText :: MonadWidget t m 
        => Dynamic t Text
        -> m ()
```
or, if we have something with a `Show` instance:
```haskell
display :: (MonadWidget t m, Show a)
        => Dynamic t a
        -> m ()
```

<div id="exercise-text"></div>

There are a few variants on `el` that are useful.

We can specify a class (or classes) for elements with:
```haskell
elClass    :: MonadWidget t m 
           => Text 
           -> Text 
           -> m a 
           -> m a
```
or if they're going to be changing over time:
```haskell
elDynClass :: MonadWidget t m 
           => Text 
           -> Dynamic t Text 
           -> m a 
           -> m a
```

<div id="exercise-class"></div>

We can specify attributes for elements with:
```haskell
elAttr    :: MonadWidget t m 
          => Text 
          -> Map Text Text 
          -> m a 
          -> m a
```
or if they're going to be changing over time:
```haskell
elDynAttr :: MonadWidget t m 
          => Text 
          -> Dynamic t (Map Text Text)
          -> m a 
          -> m a
```

There is a helper function which provides an inline version of `Map.singleton`:
```haskell
(=:) :: Ord k => k -> v -> Map k v
(=:) = Map.singleton
```
which we can use to get back to `elClass`:
```haskell
elClass :: MonadWidget t m 
        => Text 
        -> Text 
        -> m a 
        -> m a
elClass e c w =
  elAttr e ("class" =: c) w
```

<div id="exercise-attributes"></div>

If you take any of the `elXYZ` functions and turn it into `elXYZ'`, it will return an additional value that you can use to hook into the DOMs event handling.

If we turn:
```haskell
el  :: MonadWidget t m 
    => Text 
    -> m a 
    -> m a
```
into:
```haskell
el' :: MonadWidget t m 
    => Text 
    -> m a 
    -> m (El, a)
```
we can use `domEvent` on the `El` value to create a `reflex` `Event`:
```haskell
clickMe :: MonadWidget t m 
        => m (Event t ())
clickMe = do
  (e, _) <- el' "div" (text "Click me")
  pure (domEvent Click e)
```

<div id="exercise-events"></div>

There is a button input built-in to `reflex-dom`

```haskell
button :: DomBuilder t m 
       => Text 
       -> m (Event t ())
```

In `src/Util/Bootstrap.hs`, we have:
```haskell
buttonClass :: MonadWidget t m 
            => Text 
            -> Text 
            -> m (Event t ())
```
to give you clickable `div`s.

If you use `buttonClass "Click me" "btn"` you'll get a Bootstrap-styled `div`-based button, if that's something you'd prefer.

<div id="exercise-button"></div>

There is also a `reflex-dom` component for clickable links:
```haskell
link      :: DomBuilder t m 
          => Text 
          -> m (Link t)

linkClass :: DomBuilder t m 
          => Text 
          -> Text 
          -> m (Link t)
```

The `Link` type is the first data structure we've come across for managing a `reflex-dom` component:
```haskell
newtype Link t = Link { _link_clicked :: Event t () }
```

It contains one value, which is the click `Event`, and we can access that value via the supplied `lens` like so:
```haskell
  l <- link "Click me"
  pure $ view link_clicked l
```
or in the operator form:
```haskell
  l <- link "Click me"
  pure $ l ^. link_clicked
```

We'll be seeing more of these built-in components and data structures in the next section.

Before that, we'll start creating one of our own.

<div id="exercise-todo"></div>
