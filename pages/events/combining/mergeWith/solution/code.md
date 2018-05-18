```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
                 eIn1  eIn2
```
=====

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

=====
```haskell
mergeWithSolution :: Reflex t
                  => Event t Int
                  -> Event t Int
                  -> Event t Int
mergeWithSolution eIn1 eIn2 =
  getSum <$> (Sum <$> eIn1) <> (Sum <$> eIn2)
```
