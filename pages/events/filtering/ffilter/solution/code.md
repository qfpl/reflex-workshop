```haskell
ffilterSolution :: Reflex t 
                => Event t Int 
                -> Event t Int
ffilterSolution eIn =
  never
```
=====

=====
```haskell
ffilterSolution :: Reflex t 
                => Event t Int 
                -> Event t Int
ffilterSolution eIn =
                               eIn
```
=====

=====
```haskell
ffilterSolution :: Reflex t 
                => Event t Int 
                -> Event t Int
ffilterSolution eIn =
  ffilter (_                 ) eIn
```
=====

=====
```haskell
ffilterSolution :: Reflex t 
                => Event t Int 
                -> Event t Int
ffilterSolution eIn =
  ffilter (         (`mod` 3)) eIn
```
=====

=====
```haskell
ffilterSolution :: Reflex t 
                => Event t Int 
                -> Event t Int
ffilterSolution eIn =
  ffilter ((== 0) . (`mod` 3)) eIn
```
