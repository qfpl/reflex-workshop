```haskell
buttonSolution :: MonadWidget t m
               => m ()
buttonSolution = do















```
=====
We have a blank canvas.
=====
```haskell
buttonSolution :: MonadWidget t m
               => m ()
buttonSolution = do
  eAdd <- el "div" $ 
    button "Add"
  eReset <- el "div" $ 
    button "Reset"










  
```
=====
We'll add a few buttons.
=====
```haskell
buttonSolution :: MonadWidget t m
               => m ()
buttonSolution = do
  eAdd <- el "div" $ 
    button "Add"
  eReset <- el "div" $ 
    button "Reset"

  let
    eChange =
      mergeWith (.) [
          (+ 1) <$ eAdd
        , const 0 <$ eReset
        ]
  dCount <- foldDyn ($) 0 eChange


  
```
=====
We know how to build a counter by now - and we could have imported `Workshop.Behaviors.Dynamic.Counter.Exercise` to take care of this.
=====
```haskell
buttonSolution :: MonadWidget t m
               => m ()
buttonSolution = do
  eAdd <- el "div" $ 
    button "Add"
  eReset <- el "div" $ 
    button "Reset"

  let
    eChange =
      mergeWith (.) [
          (+ 1) <$ eAdd
        , const 0 <$ eReset
        ]
  dCount <- foldDyn ($) 0 eChange

  el "div" $
    display dCount
```
=====
We display the result.
=====
```haskell
buttonSolution :: MonadWidget t m
               => m ()
buttonSolution = do
  eAdd <- el "div" $ 
    buttonClass "Add" "btn"
  eReset <- el "div" $ 
    buttonClass "Reset" "btn"

  let
    eChange =
      mergeWith (.) [
          (+ 1) <$ eAdd
        , const 0 <$ eReset
        ]
  dCount <- foldDyn ($) 0 eChange

  el "div" $
    display dCount
```
=====
We can make the buttons more Bootstrap friendly using some of the things in `src/Util/Bootstrap.hs`.
