
We have already seen ways to create `Behavior`s from values (with `pure`) and from other `Behavior`s (with `(<$>)` and `(<*>)`).

We can also create `Behavior`s from `Event`s.

We do this using a function called `hold`, which is a method of the `MonadHold` typeclass:
```haskell
class MonadHold t m where
  ...
  hold :: a -> Event t a -> m (Behavior t a)
  ...
```

The first argument is the initial value of the `Behavior` and the second argument is an `Event` which will update the `Behavior`.

There are a few points to note here.

The first point is that there is only one `Event` driving the changes to the `Behavior`.
If we want to create a `Behavior` from multiple `Event`s, we first have to combine those `Event`s.

This means we don't have to worry about different `Event`s competing with each other to make a change to a `Behavior`.

The second point is that any change to the `Behavior` will not be visible in the same frame as the firing of `Event` that is causing the change.
Instead the changes are recorded, and applied starting from the next frame.
This is why some people refer to frames as transactions.

If we query a `Behavior` with multiple `Event`s that are firing in the same frame, we will always get the same value out of it.

If this were not the case, we would be able to observe something about the order in which `Event`s fire _within_ the processing of a frame, and we'd have to keep that in mind all of the time when we were reasoning about our code.

Instead, we can reason about our how our code behaves on a frame-by-frame basis.
Once you get used to it, it makes working with time-varying state feel similar to using STM for working with concurrency.

<div id="exercise-fmap"></div>

<div id="exercise-apply"></div>

Now that we have the ability to query and to create `Behavior`s by using `Event`s, we may end up in the situation where a `Behavior` and an `Event` end up depending on each other.

This isn't as alarming as it may first seem, but it does mean that we need to be able to describe these cycles of dependence in the network.

We do this via the `RecursiveDo` language extension:
```haskell
{-# LANGUAGE RecursiveDo #-}

import Control.Monad.Fix (MonadFix)
import Reflex
```
which allows us to use `mdo` in the place of `do`:
```haskell
myFunction :: (Reflex t, MonadFix m, MonadHold t m)
           => Event t Int
           -> m (Behavior t Int)
myFunction eIn = mdo
  let 
    e = someFunction b eIn
  b <- hold 0 e
  
  let
    bOut = b + pure 2

  pure bOut
```
in order to define cycles in the network.

In these cycles, if your `Behavior`s only mutually depend on `Event`s and your `Event`s only mutually depend on `Behavior`s then you should be fine.

You _can_ do other things, but you have to think a bit more about whether your are describing a causal paradox.
That would be bad.

We can use the `rec` keyword to provide a tighter scope around the recursive parts of our code:
```haskell
myFunction :: (Reflex t, MonadFix m, MonadHold t m)
           => Event t Int
           -> m (Behavior t Int)
myFunction eIn = do
  rec
    let 
      e = someFunction b eIn
    b <- hold 0 e

  let
    bOut = b + pure 2

  pure bOut
```

Before we get into the next set of exercises, there is another FRP pattern worth knowing about.

Sometimes we will have functions return both a `Behavior t a` along with the `Event t a` that was used to build it (or `never` if the `Behavior` was created with `pure`).

The idea is that anything that wants to know about the current state can interrogate the `Behavior`, and anything that wants to know about updates to the state can deal with the `Event`.

This is related to `Behavior`s being pull-based and `Event`s being push-based, for those who are familiar with the distinction.

<div id="exercise-counter"></div>

<div id="exercise-limit"></div>

<div id="exercise-text"></div>

Now, if only there was some way to avoid the need to return that `Behavior` / `Event` pair...
