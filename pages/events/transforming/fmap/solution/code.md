```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  never
```
=====

=====
```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
            eIn
```
=====

=====
```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  _     <$> eIn
```
=====

=====
```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  (* 2) <$> eIn
```
