
This exercise has a text box as an input, which gives us an `Event t Text` whenever the contents of the text box changes.

The goal is to produce two `Event`s:

- an `Event t Text` which fires with the value "Not an Int" if the contents of the text box was not an integer
- an `Event t Int` which fires when the contents of the text box could be converted to an integer

You should open `~/reflex-workshop/code/src/Workshop/Event/Filtering/FmapMaybe/Exercise.hs` and fill out this function:

```haskell
fmapMaybeExercise :: Reflex t 
                  => Event t Text 
                  -> (Event t Text, Event t Int)
fmapMaybeExercise eIn =
  (never, never)
```

to make this happen.

The file already contains a relevant helper function:
```haskell
convert :: Text -> Maybe Int
convert = readMaybe . Text.unpack
```

