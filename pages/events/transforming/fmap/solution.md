```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  never
```
=====
The `never` `Event` isn't what we want.

  
=====
```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
            eIn
```
=====
We're going to do something based on the input `Event`.

  
=====
```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  _     <$> eIn
```
=====
We're going to use `fmap`.

It seems appropriate, and it's currently the only tool in the toolbox.
=====
```haskell
fmapExercise :: Reflex t 
             => Event t Int 
             -> Event t Int
fmapExercise eIn = 
  (* 2) <$> eIn
```
=====
The function that we are going to map over the `Event` is `(* 2)`.

  
