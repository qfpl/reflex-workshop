```haskell
fmapConstExercise3 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise3 eIn =
  never

fmapConstExercise5 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise5 eIn =
  never
```
=====

=====
```haskell
fmapConstExercise3 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise3 eIn =
       eIn

fmapConstExercise5 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise5 eIn =
       eIn
```
=====

=====
```haskell
fmapConstExercise3 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise3 eIn =
  _ <$ eIn

fmapConstExercise5 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise5 eIn =
  _ <$ eIn
```
=====

=====
```haskell
fmapConstExercise3 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise3 eIn =
  3 <$ eIn

fmapConstExercise5 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise5 eIn =
  _ <$ eIn
```
=====

=====
```haskell
fmapConstExercise3 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise3 eIn =
  3 <$ eIn

fmapConstExercise5 :: Reflex t 
                   => Event t () 
                   -> Event t Int
fmapConstExercise5 eIn =
  5 <$ eIn
```
