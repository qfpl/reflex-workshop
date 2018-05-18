
Sometimes we'd like to pass an `Event` "up".
This happens if we're collecting errors to displayed in the one place.

There is a newtype that assists with this:
```haskell
newtype EventWriterT t w m a
```
via an associated typeclass and its instances:
```haskell
class (Monad m, Semigroup w) => EventWriter t w m | m -> t w where
  tellEvent :: Event t w -> m ()
```

All of the `Event`s that get passed to `tellEvent` are merged with the `Semigroup` instance, and
we can access them using `runEventWriter`:
```haskell
runEventWriterT :: (Reflex t, Monad m, Semigroup w) => EventWriterT t w m a -> m (a, Event t w)
```

=====

We could push the usage of this through to our components.

The change to `todoRemove` is pretty straightforward:
```haskell
todoRemove :: MonadWidget t m
           => EventWriterT t () m ()
todoRemove =
  divClass "p-1" $ do
     eRemove <- button "x"
     tellEvent eRemove
```

We have all the right instances we need to just change the type of `todoTextRead`:
```haskell
todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> Workflow t (EventWriterT t () m) (Event t (Text -> Text))
```
which eventually leads to:
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> EventWriterT t () m (Event t (Text -> Text))
```

The fact the `MonadWidget` is a set of constraints means that we can use `todoComplete` unchanged:
```haskell
todoComplete :: MonadWidget t m
             => Bool
             -> m (Event t (Bool -> Bool))
```

We could go even further and use `EventWriter` for all of our output.

We would need to create a data type that has a `Monoid` instance:
```haskell
data ItemState =
  ItemState (Endo TodoItem) Any

instance Semigroup ItemState where ...
instance Monoid ItemState where ...
```
and probably helper functions like: 
```haskell
tellRemove  :: (Reflex t, EventWriter t ItemState m) 
            => Event t a
            -> m ()
tellRemove e =
  tellEvent $ ItemState mempty (Any True) <$ e
  
tellChange :: (Reflex t, EventWriter t ItemState m)
           => Lens' s a
           -> Event t a
           -> m ()
tellChange l e =
  tellEvent $ (\x -> ItemState (Endo (set l x)) mempty) <$> e
```
and then we could work towards a uniform output type for our components:
```haskell
todoRemove   :: MonadWidget t m
             => EventWriterT t ItemState m ()

todoText     :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> EventWriterT t ItemState m ()

todoComplete :: MonadWidget t m
             => Bool
             -> EventWriterT t ItemState m ()
```
