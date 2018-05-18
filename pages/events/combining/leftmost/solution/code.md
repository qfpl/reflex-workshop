```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =








    (_    , _    , _        , _        )
```
=====

=====
```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)





  in
    (_    , _    , _        , _        )
```
=====

=====
```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)
    eFizz = "Fizz" <$ ffilter (multiple 3) eIn




  in
    (eFizz, _    , _        , _        )
```
=====

=====
```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)
    eFizz = "Fizz" <$ ffilter (multiple 3) eIn
    eBuzz = "Buzz" <$ ffilter (multiple 5) eIn



  in
    (eFizz, eBuzz, _        , _        )
```
=====

=====
```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)
    eFizz = "Fizz" <$ ffilter (multiple 3) eIn
    eBuzz = "Buzz" <$ ffilter (multiple 5) eIn
    eFizzBuzz = eFizz <> eBuzz


  in
    (eFizz, eBuzz, eFizzBuzz, _        )
```
=====

=====
```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)
    eFizz = "Fizz" <$ ffilter (multiple 3) eIn
    eBuzz = "Buzz" <$ ffilter (multiple 5) eIn
    eFizzBuzz = eFizz <> eBuzz
    tshow = Text.pack . show

  in
    (eFizz, eBuzz, eFizzBuzz, _        )
```
=====

=====
```haskell
leftmostSolution :: Reflex t
                 => Event t Int
                 -> ( Event t Text
                    , Event t Text
                    , Event t Text
                    , Event t Text
                    )
leftmostSolution eIn =
  let
    multiple n = (== 0) . (`mod` n)
    eFizz = "Fizz" <$ ffilter (multiple 3) eIn
    eBuzz = "Buzz" <$ ffilter (multiple 5) eIn
    eFizzBuzz = eFizz <> eBuzz
    tshow = Text.pack . show
    eSolution = leftmost [eFizzBuzz, tshow <$> eIn]
  in
    (eFizz, eBuzz, eFizzBuzz, eSolution)
```
