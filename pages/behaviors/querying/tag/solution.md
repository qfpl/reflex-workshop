```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  never
```
=====
There are lot of ways that we can approach this.
=====
```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  tag ((* 5) <$> bIn) eIn
```
=====
We can modify the `Behavior` and then tag it with the `Event`.
=====
```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  (* 5) <$> tag bIn eIn
```
=====
We can tag the `Behavior` with the `Event` and then modify the resulting `Event`...
=====
```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  (* 5) <$> bIn <@ eIn
```
=====
... which we can also do with an operator.
=====
```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  (\b _ -> b * 5) <$> bIn <@> eIn
```
=====
The `Event` isn't supplying an interesting value, but we can stretch the example to demonstrate a related operator ...
=====
```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  attachWith (\b _ -> b * 5) bIn eIn
```
=====
... and some related functions ...
=====
```haskell
tagExercise :: Reflex t
            => Behavior t Int
            -> Event t ()
            -> Event t Int
tagExercise bIn eIn =
  attachWithMaybe (\b _ -> Just (b * 5)) bIn eIn
```
=====
... particularly if we _really_ stretch the example.

