```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 

  
  
  
        
        
        
```
=====
We'll start with the todo item.
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 
  el "div" $ do
  
  
  
        
        
        
```
=====
We wrap it in a `div`.
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 
  el "div" $ do
    el "div" $
      text $
        _
        
        
        
```
=====
We add another `div` to display the text ...
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 
  el "div" $ do
    let iText = view todoItem_text item
    el "div" $
      text iText
        
        
        
```
=====
... which we get using the lens and `view` ...
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 
  el "div" $ do
    let iText = item ^. todoItem_text
    el "div" $
      text iText
        
        
        
```
=====
... or the operator form if we are comfortable with that.
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 
  el "div" $ do
    let iText = item ^. todoItem_text
    el "div" $
      text iText
    el "div" $
      button "x"
```
=====
We then add a button for removing the item, and return the `Event` that fires when the button is clicked.
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item = 
  divClass "d-flex flex-row align-items-center" $ do
    let iText = item ^. todoItem_text
    divClass "p-1" $
      text iText
    divClass "p-1" $
      button "x"
```
=====
If you're familiar with Bootstrap, we can add some classes to make this a little prettier with Flexbox and friends.
=====
```haskell
todoSolution :: MonadWidget t m
             => TodoItem 
             -> m ()
todoSolution item = do


    
    
    
    
    
    
    
  _
```
=====
Now we need to wrap this up in a test harness of some kind.
=====
```haskell
todoSolution :: MonadWidget t m
             => TodoItem 
             -> m ()
todoSolution item = do
  eRemove <- el "div" $
    todoItem item
    
    
    
    
    
    
    
    
```
=====
We'll put a sample item in a `div`.
=====
```haskell
todoSolution :: MonadWidget t m
             => TodoItem 
             -> m ()
todoSolution item = do
  eRemove <- el "div" $
    todoItem item

  dCount <- count eRemove





  
```
=====
We use `count` here.
=====
```haskell
todoSolution :: MonadWidget t m
             => TodoItem 
             -> m ()
todoSolution item = do
  eRemove <- el "div" $
    todoItem item

  dCount <- count eRemove

  el "div" $ do
    text "Remove has been pressed "
    display dCount
    text " time"
    dynText $ bool "s" "" . (== 1) <$> dCount
```
=====
All that remains is to display the number of times the remove button was clicked.
