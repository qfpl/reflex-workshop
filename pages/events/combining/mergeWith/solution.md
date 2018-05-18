```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
                 eIn1  eIn2
```
=====
We're going to approach this problem in two ways.
=====
```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
  mergeWith (+) [eIn1, eIn2]
```
=====
The simplest approach is to use `mergeWith (+)`.
=====
```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
                      eIn1              eIn2
```
=====
The other approach is to use the `Monoid` instance.
=====
```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
                      eIn1  <>          eIn2
```
=====
To `mappend` the two `Event`s, the value of the `Event` needs a `Monoid` instance ...
=====
```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
             (Sum <$> eIn1) <> (Sum <$> eIn2)
```
=====
... so we wrap them up in the `Sum` monoid ...
=====
```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
  getSum <$> (Sum <$> eIn1) <> (Sum <$> eIn2)
```
=====
... and unwrap the result of the `mappend`.
