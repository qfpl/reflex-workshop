```haskell
fmapSolution :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapSolution bIn =
  pure 0
```
=====
This clearly isn't want (and it explains why the output is always `0`).
=====
```haskell
fmapSolution :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapSolution bIn =
            bIn
```
=====
We make use of the input `Behavior` ...
=====
```haskell
fmapSolution :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapSolution bIn =
  _     <$> bIn
```
=====
... and the `Functor` instance ...
=====
```haskell
fmapSolution :: Reflex t
             => Behavior t Int
             -> Behavior t Int
fmapSolution bIn =
  (* 5) <$> bIn
```
=====
... to transform the `Behavior` with an appropriate function.
