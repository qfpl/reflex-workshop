```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =








    (_     , _   )
```
=====
We're going to do this in 3 different ways.

  
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
In the first approach, we're going to use `(<$>)` instead of `fmapMaybe` with `convert :: Text -> Maybe Int`.

We're doing this we need to do the conversion _and_ report on errors.
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
We then use `fmapMaybe id` to filter out and remove the `Nothing` values for the success case...

  
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
... and `ffilter isNothing` to deal with the failure case

  
=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =






    (_     , _   )
    
    
```
=====
In the second approach, we're going to use `fmapMaybe` directly.

  
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
This deals with the success case straight away.

  
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
We're going to use `difference` to report on errors.

  
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
We want an `Event` which fires every time that `eIn` fires, as long as `eOut` isn't firing at the same time.

The types don't quite line up though.
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
We can use `void` to handle this ...

  
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
... and then we just need to add the error message.

  
=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  _
  
  
  
 
 
 
 
  
```
=====
For the third approach, we'll make use of the `errors` package.

 
=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
                                              eIn
  
  
  
 
 
 
 
  
```
=====
We start with the input `Event t Text`.

 
=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
                                  convert <$> eIn
  
  
  
 
 
 
 
  
```
=====
We could convert it to an `Event t (Maybe Int)` ...

 
=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
              note "Not an Int" . convert <$> eIn
  
  
  
 
 
 
 
  
```
=====
... but instead we convert it to an `Event t (Either Text Int)` ...

 
=====
```haskell
fmapMaybeSolution :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeSolution eIn =
  fanEither $ note "Not an Int" . convert <$> eIn
  
  
  
 
 
 
 
  
```
=====
... and then use `fanEither` to split out the `Event`s corresponding to successes and failures

   
