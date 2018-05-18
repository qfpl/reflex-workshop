```haskell
todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> Workflow t m (Event t (Text -> Text), Event t ())
todoTextRead dComplete iText = Workflow $ do
  pure ((_, _), todoTextWrite <$ _)

todoTextWrite :: MonadWidget t m
              => Dynamic t Bool
              -> Text
              -> Workflow t m (Event t (Text -> Text), Event t ())
todoTextWrite dComplete iText = Workflow $ do
  pure ((_, _), todoTextRead <$> _)
```
=====
We're going to start with two helper functions.
=====
```haskell
todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> Workflow t m (Event t (Text -> Text), Event t ())
todoTextRead dComplete iText = Workflow $ do
  let
    dCompleteClass = bool "" " completed" <$> dComplete
            elDynClass  "div" (pure "p-1" <> dCompleteClass) $
    text iText
  pure ((never, never), todoTextWrite dComplete iText <$ _                  )
```
=====
The text-displaying `Workflow` value is similar to our very first version of `todoText` ...
=====
```haskell
todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> Workflow t m (Event t (Text -> Text), Event t ())
todoTextRead dComplete iText = Workflow $ do
  let
    dCompleteClass = bool "" " completed" <$> dComplete
  (e, _) <- elDynClass' "div" (pure "p-1" <> dCompleteClass) $
    text iText
  pure ((never, never), todoTextWrite dComplete iText <$ domEvent Dblclick e)
```
=====
... but we need to detect double clicks to change over to the text-editing `Workflow`.
=====
```haskell
todoTextWrite :: MonadWidget t m
              => Dynamic t Bool
              -> Text
              -> Workflow t m (Event t (Text -> Text), Event t ())
todoTextWrite dComplete iText = Workflow $ do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter   = keypress Enter ti
      bText    = current $ value ti
      eText    = Text.strip <$> bText <@ eEnter
      eNotNull =       ffilter (not . Text.null) eText
      eRemove  = () <$ ffilter        Text.null  eText
      eChange  = const <$> eNotNull
    pure ((eChange, eRemove), todoTextRead dComplete <$> _       )
```
=====
The text-editing `Workflow` value is similar to our second version of `todoText` ...
=====
```haskell
todoTextWrite :: MonadWidget t m
              => Dynamic t Bool
              -> Text
              -> Workflow t m (Event t (Text -> Text), Event t ())
todoTextWrite dComplete iText = Workflow $ do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter   = keypress Enter ti
      bText    = current $ value ti
      eText    = Text.strip <$> bText <@ eEnter
      eNotNull =       ffilter (not . Text.null) eText
      eRemove  = () <$ ffilter        Text.null  eText
      eChange  = const <$> eNotNull
    pure ((eChange, eRemove), todoTextRead dComplete <$> eNotNull)
```
=====
... and we pass the new text along to the text-displaying `Workflow`.
=====
```haskell
todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  des <- workflow $ todoTextRead dComplete iText

  let
    eChange = switchDyn . fmap fst $ des
    eRemove = switchDyn . fmap snd $ des

  pure (eChange, eRemove)
```
=====
After that we run the workflow and then unpack the `Event`s.
