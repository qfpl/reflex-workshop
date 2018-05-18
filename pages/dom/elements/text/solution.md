```haskell
textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn =
  pure ()
    
    
```
=====
We need to put something on the screen.
=====
```haskell
textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn = do
  el "div" $
    pure ()
    
    
```
=====
We'll start with an empty `div` ...
=====
```haskell
textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn = do
  el "div" $
    text "Input"
    
    
```
=====
and then add some static text as a label.
=====
```haskell
textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn = do
  el "div" $
    text "Input"
  el "div" $
    dynText ""
```
=====
We can then use `dynText` ...
=====
```haskell
textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn = do
  el "div" $
    text "Input"
  el "div" $
    dynText $ Text.pack . show <$> dIn
```
=====
... to display our input ...
=====
```haskell
textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn = do
  el "div" $
    text "Input"
  el "div" $
    display dIn
```
=====
... or we can use a built-in helper function to do that.

 
