```haskell
counterTextSolution :: Reflex t
                    => Behavior t Int
                    -> Behavior t Text
                    -> Event t ()
                    -> Event t ()
                    -> (Event t Text, Event t Int)
counterTextSolution bCount bText eAdd eReset =
  let
  
  
      
      
  in
    (_     , _     )
```
=====
We can do this with two of our existing solutions.
=====
```haskell
counterTextSolution :: Reflex t
                    => Behavior t Int
                    -> Behavior t Text
                    -> Event t ()
                    -> Event t ()
                    -> (Event t Text, Event t Int)
counterTextSolution bCount bText eAdd eReset =
  let
    (eError, eIn) =
      fmapMaybeSolution $ bText <@ eAdd
      
      
  in
    (eError, _     )
```
=====
First we get the value of `bText` when the "Add" button was pressed, then we separate the errors from the successful conversions to `Int`s.
=====
```haskell
counterTextSolution :: Reflex t
                    => Behavior t Int
                    -> Behavior t Text
                    -> Event t ()
                    -> Event t ()
                    -> (Event t Text, Event t Int)
counterTextSolution bCount bText eAdd eReset =
  let
    (eError, eIn) =
      fmapMaybeSolution $ bText <@ eAdd
    eCount =
      counterSolution' bCount eIn eReset
  in
    (eError, eCount)
```
=====
Then we feed whatever `Int`s make it through into our counter.
