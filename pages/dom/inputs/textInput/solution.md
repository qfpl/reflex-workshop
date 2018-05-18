```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do


       
       
        
        




      
      
    pure (_      , _      )
```
=====
We start with a blank canvas ...
=====
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
        
        
        




      
      
    pure (_      , _      )
```
=====
... and set up our usual `Dynamic` class.
=====
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass




      
      
    pure (_      , _      )
```
=====
That is all we need to configure our text input.
=====
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter  = keypress Enter ti
      bText   = current $ value ti

      
      
    pure (_      , _      )
```
=====
We get hold of a `Behavior` with the `Text` from the text input in it, and an `Event` which fires when the user presses Enter ...
=====
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter  = keypress Enter ti
      bText   = current $ value ti
      eText   = Text.strip <$> bText <@ eEnter
      
      
    pure (_      , _      )
```
=====
... and we turn that into an `Event` that fires with the stripped `Text` from the text input at the moment that the Enter key was pressed. 
=====
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter  = keypress Enter ti
      bText   = current $ value ti
      eText   = Text.strip <$> bText <@ eEnter
      eChange = const <$> ffilter (not . Text.null) eText
      eRemove = ()    <$  ffilter        Text.null  eText
    pure (eChange, eRemove)
```
=====
We turn that `Event` into the change and removal `Event`s and return them.
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    eComplete <- todoComplete iComplete
    dComplete <- foldDyn ($) iComplete eComplete
                            todoText dComplete iText
    eRemove       <- todoRemove











    pure (_      , _      )
```
=====
We start with something similar to what we had before...
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    eComplete <- todoComplete iComplete
    dComplete <- foldDyn ($) iComplete eComplete
    (eText, eRemoveText) <- todoText dComplete iText
    eRemoveButton <- todoRemove











    pure (_      , _      )
```
=====
... but we need to name or rename some `Event`s.
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    eComplete <- todoComplete iComplete
    dComplete <- foldDyn ($) iComplete eComplete
    (eText, eRemoveText) <- todoText dComplete iText
    eRemoveButton <- todoRemove

    let
      eChange = mergeWith (.) [
          over todoItem_complete <$> eComplete
        , over todoItem_text     <$> eText
        ]





    pure (eChange, _      )
```
=====
Then we collect and return the change `Event`s ...
=====
```haskell
todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    eComplete <- todoComplete iComplete
    dComplete <- foldDyn ($) iComplete eComplete
    (eText, eRemoveText) <- todoText dComplete iText
    eRemoveButton <- todoRemove

    let
      eChange = mergeWith (.) [
          over todoItem_complete <$> eComplete
        , over todoItem_text     <$> eText
        ]
      eRemove = leftmost [
          eRemoveText
        , eRemoveButton
        ]

    pure (eChange, eRemove)
```
=====
... and the removal `Event`s.
