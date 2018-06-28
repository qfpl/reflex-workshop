`Behavior`s have values at all points in time and `Event`s have values at particular instants in time.

We can use an `Event` to sample a `Behavior` at all of the points of time when the `Event` is firing.

We can grab the value of the `Behavior` when the `Event` fires:
```haskell
tag             :: Reflex t 
                => Behavior t a 
                -> Event t b 
                -> Event t a
```
and there is an operator form:
```haskell
(<@)            :: Reflex t 
                => Behavior t a 
                -> Event t b 
                -> Event t a
```

If we want to use the value of the `Event` as well, there is a related operator:
```haskell
(<@>)           :: Reflex t 
                => Behavior t (a -> b) 
                -> Event t a 
                -> Event t b
```
a function that lets us be explicit about how we will combine the `Behavior` and `Event` values:
```haskell
attachWith      :: Reflex t 
                => (a -> b -> c) 
                -> Behavior t a 
                -> Event t b 
                -> Event t c
```
and a version that allows us to filter out some results at the same time:
```haskell
attachWithMaybe :: Reflex t 
                => (a -> b -> Maybe c) 
                -> Behavior t a 
                -> Event t b 
                -> Event t c
```

The operators are often used with `Applicative` style code to sample a number of `Behavior`s with an `Event`.

We do things like this if we want the value from the `Event`:
```haskell
fn <$> bArg1 <*> bArg2 <@> eArg3
```
or otherwise:
```haskell
fn <$> bArg1 <*> bArg2 <@ eArg3
```

<div id="exercise-tag"></div>

Now that we've warmed up, let's build something a little more useful.

<div id="exercise-counter"></div>

In the above exercise, we were passing a `Behavior t Int` into the function and getting an `Event t Int` as an output, which is being used behind the scenes to update the `Behavior`.

It is worth noting that we don't need to pass in the `Behavior` to achieve the same result.
To do this, we need to move from returning an `Event t Int` to returning an `Event t (Int -> Int)`:

```haskell
counterAlt :: Reflex t
           => Event t ()
           -> Event t ()
           -> Event t (Int -> Int)
counterAlt eAdd eReset =
  mergeWith (.) [
      const 0 <$ eReset
    , (+ 1)   <$ eAdd
    ]
```

We could have used `leftmost` here, if we were sure that the input events were always going to be mutually exclusive.
If you can use `mergeWith` it is worth doing, since it will make your functions more robust in the face of change (and will force you to think about edge cases in the process).

We'll put that aside for a moment, but we'll be coming back to it.

<div id="exercise-counterText"></div>

We have one last function to cover in this section.

We can use `gate` as a time-varying filter for `Event`s:
```haskell
gate :: Reflex t 
     => Behavior t Bool 
     -> Event t a 
     -> Event t a
```

<div id="exercise-limit"></div>

Next up, we'll look at how to create `Behavior`s from `Event`s...
