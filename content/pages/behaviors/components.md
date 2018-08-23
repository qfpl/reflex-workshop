
One of the things that `reflex` is less opinionated about is how you should structure your components.

There are a few common patterns that come up though, and I've found that they're a good starting point for when you find yourself staring at the screen and wondering what to do.

The main pattern has two parts to it.

If we're writing a component, we normally pass in `Dynamic`s that represent the state of our application that we need to access, and we return `Event`s to indicate what we would like to change.

Like this:
```haskell
handleThing :: (Reflex t, MonadFix m, MonadHold t m) 
            => Dynamic t Config 
            -> Dynamic t Thing 
            -> m (Event t (Thing -> Thing))
```

We have some good information hiding here.
If you need to create new `Event`s, fire off and handle some network requests, or make use of other components internally, you are free to do so.
It won't clutter up any global state or have any effect on the reasoning that will have to be done by whoever uses your component.

Eventually we'll have to use those `Event`s to create that `Dynamic`, like this:
```haskell
...
useThing :: (Reflex t, MonadFix m, MonadHold t m) 
         => Dynamic t Config
         -> m ()
useThing = mdo
   ...
   eThingFn <- handleThing dConfig dThing
   dThing   <- foldDyn ($) initialThing eThingFn
   ...
```
and we usually try to do this as close to component as makes sense.

That will partly depend on how much cross-pollination there is between components and how much information we want to share or hide.

Sometimes we might want the option of managing the state of our component internally, in which case we can supply an initial value instead of a `Dynamic`:
```haskell
handleThing :: (Reflex t, MonadFix m, MonadHold t m) 
            => Dynamic t Config 
            -> Thing 
            -> m (Event t (Thing -> Thing))
```
and we can use that to build a `Dynamic` later on if something else needs it:
```haskell
...
useThing :: (Reflex t, MonadFix m, MonadHold t m) 
         => Dynamic t Config
         -> m ()
useThing = mdo
   ...
   eThingFn <- handleThing dConfig initialThing
   dThing   <- foldDyn ($) initialThing eThingFn
   ...
```
or we can roll that step into our main function if it is always going to be done anyhow:
```haskell
handleThing :: (Reflex t, MonadFix m, MonadHold t m) 
            => Dynamic t Config 
            -> Thing 
            -> m (Dynamic t Thing)
```

Any of these approaches can be a good starting point, and we'll see its influence throughout the remainder of the workshop.

We can get more mileage out of this pattern if we have lenses for our data types, so we'll take a brief detour through the world of lenses before we continue.

If we set up a data type like so:
```haskell
data Thing = 
  Thing {
    _subthing   :: SubThing
  , _otherthing :: OtherThing
  }
```
and invoke some Template Haskell
```haskell
makeLenses ''Thing
```
we will end up with a `Lens` for each of the components of our data type:
```haskell
subthing   :: Lens' Thing SubThing
otherthing :: Lens' Thing OtherThing
```

What does this give us?
It gives us composable getters and setters and a pile of related tools.

We can turn a `lens` into a getter with `view`:
```haskell
view subthing :: Thing -> SubThing
```

In operator form, 
```haskell
view subthing t
```
will look like:
```haskell
t ^. subthing
```

We can turn a `lens` into a setter with `set`:
```haskell
set subthing :: SubThing -> Thing -> Thing
```

We use `(&)` to combine these, and so in operator form,
```haskell
set otherthing ot . 
set subthing st $ 
t
```
will look like:
```haskell
t & subthing .~ st
  & otherthing .~ ot
```

We can also use a `lens` to build something that will apply a function to a subpart of our data type:
```haskell
over subthing :: (SubThing -> SubThing) -> Thing -> Thing
```

If we have the above lenses and have components written for the subparts:
```haskell
handleSubThing   :: (Reflex t, MonadFix m, MonadHold t m) 
                 => Dynamic t SubThing 
                 -> m (Event t (SubThing -> SubThing))

handleOtherThing :: (Reflex t, MonadFix m, MonadHold t m) 
                 => Dynamic t OtherThing 
                 -> m (Event t (OtherThing -> OtherThing))
```
then you could so something like this to combine them:
```haskell
handleThing      :: (Reflex t, MonadFix m, MonadHold t m) 
                 => Dynamic t Thing
                 -> m (Event t (Thing -> Thing))
handleThing dThing = do
  dSubThing   <- holdUniqDyn $ view subthing   <$> dThing
  dOtherThing <- holdUniqDyn $ view otherthing <$> dThing
  
  eSubThingFn   <- handleSubThing   dSubThing
  eOtherThingFn <- handleOtherThing dOtherThing
  
  pure $ mergeWith (.) [
      over subthing   <$> eSubThingFn
    , over otherthing <$> eOtherThingFn
    ]
```
or this:
```haskell
handleThing      :: (Reflex t, MonadFix m, MonadHold t m) 
                 => Thing
                 -> m (Event t (Thing -> Thing))
handleThing initialThing = do
  let
    initialSubThing   = view subthing   initialThing
    initialOtherThing = view otherthing initialThing
  
  eSubThingFn   <- handleSubThing   initialSubThing
  eOtherThingFn <- handleOtherThing initialOtherThing
  
  pure $ mergeWith (.) [
      over subthing   <$> eSubThingFn
    , over otherthing <$> eOtherThingFn
    ]
```

This give us the ability to combine these components, and lets us decide which state is important enough to gather up with a `holdDyn` and pass around our application.

As an aside, we could have had our components return changed values instead of functions:
```haskell
handleSubThing   :: (Reflex t, MonadFix m, MonadHold t m) 
                 => Dynamic t SubThing 
                 -> m (Event t SubThing)
```
and then use `set` instead of `over`:
```haskell
      set subthing <$> eSubThingFn
```
but we would lose the ability to cleanly merge updates of different subparts when the updated were driven by the same event.

