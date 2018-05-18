
If we a collection of things that we want to display or manage, there are functions that can help us.

The main function we will be looking at is:
```haskell
listHoldWithKey :: (Ord k, MonadWidget t m) 
                => Map k v 
                -> Event t (Map k (Maybe v)) 
                -> (k -> v -> m a) 
                -> m (Dynamic t (Map k a))
```

It takes a `Map` as the initial value of the collection, an `Event` which fires on insertions and deletions (and possibly also on externally driven alterations), and a function to display a member of the `Map` given the key and value.
It collects the results of the supplied function up in a `Dynamic t (Map k a)`.

If we are using `listHoldWithKey`, we manage the state of our collection elements from the inside of the elements themselves.
This means we have work to do if we want to model the state of the whole collection as a `Dynamic t (Map k v)` and pass it to another part of our program.

=====

There are same handy functions we can use when adding to these collections:
```haskell
numberOccurrences     :: (Reflex t, MonadHold t m, MonadFix m, Num b) 
                      => Event t a 
                      -> m (Event t (b, a))

numberOccurrencesFrom :: (Reflex t, MonadHold t m, MonadFix m, Num b) 
                      => b 
                      -> Event t a 
                      -> m (Event t (b, a))
```
=====

There is another function which can be handy when working with the output from `listHoldWithKey` and other functions like it:
```haskell
mergeMap :: (Reflex t, Ord k) 
         => Map k (Event t a) 
         -> Event t (Map k a)
```

=====

This function is also handy when dealing with the output of the collection functions:
```haskell
joinDynThroughMap :: (Reflex t, Ord k) 
                  => Dynamic (Map k (Dynamic a)) 
                  ->  Dynamic (Map k a)
```

=====

There are other functions for handling lists:

```haskell
listWithKey :: (Ord k, MonadWidget t m) 
            => Dynamic t (Map k v) 
            -> (k -> Dynamic t v -> m a) 
            -> m (Dynamic t (Map k a))

list        :: (Ord k, MonadWidget t m) 
            => Dynamic t (Map k v) 
            -> (Dynamic t v -> m a) 
            -> m (Dynamic t (Map k a))

simpleList  :: MonadWidget t m
            => Dynamic t [v] 
            -> (Dynamic t v -> m a) 
            -> m (Dynamic t [a])
```

I recommend using `listHoldWithKey` when you are building up or manipulating some kind of dynamic collection, and to use the other functions when you have a dynamic collection that you need to display.

As an example, the harness that runs the previous exercise is using `simpleList` to display the completed items:
```haskell
  divClass "row" $ do
    dItems <- divClass "col" $
      fn items

    let
      dComplete =
        fmap (view todoItem_text) . filter (view todoItem_complete) <$> dItems

    divClass "col" $ do
      el "div" . text $ "Completed items"
      el "ul" . simpleList dComplete $
        el "li" . dynText
```

You can use these functions to build up your collection, but you'll have to do some contortions to make it work.
If you find yourself fighting the API, try something else.
