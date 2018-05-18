```haskell
applySolution :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applySolution eIn = do







  pure (_ , _ )
```
=====
This exercise is more about `Event` wrangling.
=====
```haskell
applySolution :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applySolution eIn = do
  let
    multiple n =
      (== 0) . (`mod` n)
      
      
      
      
  pure (_ , _ )
```
=====
We make use of the `multiple` function that we wrote for the FizzBuzz example.
=====
```haskell
applySolution :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applySolution eIn = do
  let
    multiple n =
      (== 0) . (`mod` n)
    downsample n =
      fmap (`div` n) . ffilter (multiple n)
      
      
  pure (_ , _ )
```
=====
We write another function that filters an `Event t Int` to allow through multiples of `n` before dividing the values by `n`.
=====
```haskell
applySolution :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applySolution eIn = do
  let
    multiple n =
      (== 0) . (`mod` n)
    downsample n =
      fmap (`div` n) . ffilter (multiple n)
  b2 <- hold 0 $ downsample 2 eIn
  b3 <- hold 0 $ downsample 3 eIn
  pure (b2 , b3)
```
=====
Then we can create our `Behavior`s and return them.
