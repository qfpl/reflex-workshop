
So far we have only looked at static FRP networks. We can go beyond that with higher-order FRP.


We can use `Event`s to trigger changes in the FRP network:
```haskell
switchHold :: (Reflex t, MonadHold t m) 
           => Event t a 
           -> Event t (Event t a) 
           -> m (Event t a)
           
switcher   :: (Reflex t, MonadHold t m) 
           => Behavior t a 
           -> Event t (Behavior t a) 
           -> m (Behavior t a)
```
or we can build `Behavior`s or `Dynamic`s that capture the changing meaning of an `Event` over time:
```haskell
switch     :: Reflex t 
           => Behavior t (Event t a) 
           -> Event t a

switchDyn  :: Reflex t 
           => Dynamic t (Event t a) 
           -> Event t a
```

The `Monad` instances for `Behavior` and `Dynamic` give us some other higher-order FRP functions:
```haskell
join       :: Reflex t 
           => Behavior t (Behavior t a) 
           -> Behavior t a

join       :: Reflex t 
           => Dynamic t (Dynamic t a) 
           -> Dynamic t a
```
and there is another related function which will come in handy soon:
```haskell
joinDynThroughMap :: (Reflex t, Ord k) 
                  => Dynamic (Map k (Dynamic a)) 
                  ->  Dynamic (Map k a)
```

<div id="exercise-higherOrder"></div>

If we want to switch out bits of the DOM based on `Event`s or `Dynamic`s, we can use:
```haskell
widgetHold :: MonadWidget 
           => m a 
           -> Event t (m a) 
           -> m (Dynamic t a)
```
or:
```haskell
dyn        :: MonadWidget t m 
           => Dynamic t (m a) 
           -> m (Event t a)
```

We usually try to use `widgetHold` if we can, since `dyn` has to do some work when it gets laid out on the page that can result in slightly less smooth initial rendering.

<div id="exercise-widgetHold"></div>

Some people might find the `Workflow` type helpful for their higher-order FRP needs:
```haskell
newtype Workflow t m a = 
  Workflow { 
    unWorkflow :: m (a, Event t (Workflow t m a))
  }

workflow :: MonadWidget t m 
         => Workflow t m a 
         -> m (Dynamic t a)
```

An example often helps, and I usually use pagination to explain it to people:
```haskell
page1 :: Workflow t m (Event t Int)
page1 = Workflow $ do
  ...
  pure (eResult, page2 <$ eNext)

page2 :: Workflow t m (Event t Int)
page2 = Worklfow $ do
  ...
  pure (eResult, leftmost [page1 <$ ePrev, page3 <$ eNext])

page3 :: Workflow t m (Event t Int)
page3 = Workflow $ do
  ...
  pure (eResult, page2 <$ ePrev)
  
go :: m (Event t Int)
go = do
  de <- workflow page1
  pure $ switchDyn de
```

It is worth remembering that we can use the values in the `Event`s to make more interesting choices of how to move through the `Workflow`.

<div id="exercise-workflow"></div>

<div id="exercise-todo"></div>

