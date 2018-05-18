```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =








    (_     , _   )
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eMaybe =  -- Event t (Maybe Int)
      convert <$> eIn




  in
    (_     , _   )
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eMaybe =  -- Event t (Maybe Int)
      convert <$> eIn
    eOut   =  -- Event t Int
      fmapMaybe id eMaybe


  in
    (_     , eOut)
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eMaybe =  -- Event t (Maybe Int)
      convert <$> eIn
    eOut   =  -- Event t Int
      fmapMaybe id eMaybe
    eError =  -- Event t Text
      "Not an Int" <$ ffilter isNothing eMaybe
  in
    (eError, eOut)
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =






    (_     , _   )
    
    
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eOut   = -- Event t Int
      fmapMaybe convert eIn


  in
    (_     , eOut)
    
    
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eOut   = -- Event t Int
      fmapMaybe convert eIn
    eError = -- Event t Text
      _            <$ difference  _          _
  in
    (eError, eOut)
    
    
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eOut   = -- Event t Int
      fmapMaybe convert eIn
    eError = -- Event t Text
      _            <$ difference       eIn        eOut
  in
    (eError, eOut)
    
    
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eOut   = -- Event t Int
      fmapMaybe convert eIn
    eError = -- Event t Text
      _            <$ difference (void eIn) (void eOut)
  in
    (eError, eOut)
    
    
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  let
    eOut   = -- Event t Int
      fmapMaybe convert eIn
    eError = -- Event t Text
      "Not an Int" <$ difference (void eIn) (void eOut)
  in
    (eError, eOut)
    
    
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  _
  
  
  
 
 
 
 
  
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
                                              eIn
  
  
  
 
 
 
 
  
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
                                  convert <$> eIn
  
  
  
 
 
 
 
  
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
              note "Not an Int" . convert <$> eIn
  
  
  
 
 
 
 
  
```
=====

=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  fanEither $ note "Not an Int" . convert <$> eIn
  
  
  
 
 
 
 
  
```
