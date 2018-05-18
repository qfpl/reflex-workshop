```haskell
counterSolution' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterSolution' bCount eAdd eReset =
  never 
  

  
```
=====
We'll work on the more general solution first.
=====
```haskell
counterSolution' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterSolution' bCount eAdd eReset =
  leftmost [
  
  
    ]
```
=====
We're working with inputs from two buttons and, since they are mutually exclusive, we can combine them using `leftmost`.
=====
```haskell
counterSolution' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterSolution' bCount eAdd eReset =
  leftmost [
      0   <$             eReset

    ]
```
=====
If `eReset` fires, we want to fire the result with the value `0`.
=====
```haskell
counterSolution' :: Reflex t
                 => Behavior t Int
                 -> Event t Int
                 -> Event t ()
                 -> Event t Int
counterSolution' bCount eAdd eReset =
  leftmost [
      0   <$             eReset
    , (+) <$> bCount <@> eAdd
    ]
```
=====
If `eAdd` fires, we want to fire the result with the sum of the value of the `Event` and the value of `bCount` at the moment that `eAdd` fired.
=====
```haskell
counterSolution :: Reflex t
                => Behavior t Int
                -> Event t ()
                -> Event t ()
                -> Event t Int
counterSolution bCount eAdd eReset =
  never
```
=====
We can use the previous solution as part of the more specific solution ...
=====
```haskell
counterSolution :: Reflex t
                => Behavior t Int
                -> Event t ()
                -> Event t ()
                -> Event t Int
counterSolution bCount eAdd eReset =
  counterSolution' bCount (1 <$ eAdd) eReset
```
=====
... by modifying the `eAdd` `Event` so that it always has a value of `1` when it fires.
 
