
We're now going to look at a couple of the more involved components that come with `reflex-dom`.

The first of these is the checkbox:
```haskell
checkbox :: MonadWidget t m 
         => Bool 
         -> CheckboxConfig t 
         -> m (Checkbox t)
```

We supply an initial value and some configuration, and a checkbox gets added to the page.

There is an instance of `Default` for the configuration:
```haskell
instance Reflex t => Default (CheckboxConfig t) where
```
so we can do something as simple as:
```haskell
  cb <- checkbox False def
```
to get started.

If we want to alter things we can modify the configuration:
```haskell
data CheckboxConfig t = 
  CheckboxConfig { 
      _checkboxConfig_setValue   :: Event t Bool
    , _checkboxConfig_attributes :: Dynamic t (Map Text Text)
    }
```
either directly or through lenses.

There are lenses defined based on the above record definition -- `checkboxConfig_setValue` and `checkboxConfig_attributes` -- but there is also some typeclasses in play that mean that we can use the more generic lenses `setValue` and `attributes`.

Between the `Default` instance and these lenses, we can do things like:
```haskell
def & setValue   .~ eToggle
    & attributes .~ pure ("class" =: "highlight")
```
to set up the configuration object.

Once we have built a checkbox, we can extract some information from it via the data type:
```haskell
data Checkbox t = 
  Checkbox { 
      _checkbox_value  :: Dynamic t Bool
    , _checkbox_change :: Event t Bool
    }
```

The `_checkbox_value` `Dynamic` tracks the state of the checkbox and lets us know about any updates.
There is a typeclass that lets us get hold of that with the `value` function, so
```haskell
  cb ^. checkbox_value
```
is the same as
```haskell
  value cb
```

The `_checkbox_change` `Event` lets us know when there has been a UI-driven change to the checkbox.
The distinction between UI-driven changes and program-driven changes is handy, and lets us do things like this:
```haskell
  rec
    cb1 <- checkbox False $ 
      def & setValue .~ (not <$> cb2 ^. checkbox_change)
    cb2 <- checkbox True $ 
      def & setValue .~ (not <$> cb1 ^. checkbox_change)
```
without any problems.

<div id="exercise-checkbox"></div>

As a brief aside, sometimes you might want to drive a checkbox or something similar from an existing `Dynamic`.
There are two ways to do this, but one is strictly better than the other.

There is a typeclass which gives us access to an `Event` which fires as soon as we have finished building whatever we are working on:
```haskell
class PostBuild t m where
  getPostBuild :: m (Event t ())
```

We _could_ use this to get the value of the `Dynamic` just after the checkbox is rendered and use that to set the value of the checkbox:
```haskell
linkCheckbox :: MonadWidget t m 
             => Dynamic t Bool 
             -> m (Checkbox)
linkCheckbox dBool = do
  ePostBuild <- getPostBuild
  let 
    eChange = 
      leftmost [
          current dBool <@ ePostBuild
        , updated dBool
        ]
  checkbox False $ 
    def & setValue .~ eChange
```

This is not great -- if the `Dynamic` has the value `True` when the checkbox is rendered, it will start out unchecked for a frame and then quickly become checked.

There is another typeclass which hasn't been mentioned so far, because it's easy to misuse until you have a good example of where it is useful.

The `MonadSample` typeclass:
```haskell
class MonadSample t m where
  sample :: Behavior t a -> m a
```
gets hold of the value of a `Behavior` at the moment `sample` is called.

This gives us an initial value for the checkbox.
We only need an initial value and an update `Event` to drive the `Dynamic` hiding inside of the checkbox, so we are good to go:
```haskell
linkCheckbox :: MonadWidget t m 
             => Dynamic t Bool 
             -> m (Checkbox)
linkCheckbox dBool = do
  initial <- sample . current $ dBool
  checkbox initial $ 
    def & setValue .~ updated dBool
```

With that out of the way, we'll start to look at a more complicated component -- a text input:
```haskell
textInput :: MonadWidget t m 
          => TextInputConfig t 
          -> m (TextInput t)
```

We have a `Default` instance for `TextInputConfig`:
```haskell
instance Reflex t => Default (TextInputConfig t) where
```
so we can get started quickly.
```haskell
  ti <- textInput def
```

The configuration data type is similar to that for a checkbox, although we can alter the input type and the initial value is in the data type rather than being and argument to the `textInput` function:
```haskell
data TextInputConfig t = 
  TextInputConfig { 
      _textInputConfig_inputType    :: Text
    , _textInputConfig_initialValue :: Text
    , _textInputConfig_setValue     :: Event t Text
    , _textInputConfig_attributes   :: Dynamic t (Map Text Text)
    }
```

There is quite a bit more going on in the `TextInput` type itself:
```haskell
data TextInput t = 
  TextInput { 
      _textInput_value          :: Dynamic t Text
    , _textInput_input          :: Event t Text
    , _textInput_keypress       :: Event t Word
    , _textInput_keydown        :: Event t Word
    , _textInput_keyup          :: Event t Word
    , _textInput_hasFocus       :: Dynamic t Bool
    , _textInput_builderElement :: InputElement EventResult GhcjsDomSpace t
    }
```
although `_textInput_value` and `_textInput_input` seem to be used the most, and are similar to `_checkbox_value` and `_checkbox_change` in how they function.

There is a typeclass that lets us easily access DOM events on the text input:
```haskell
instance Reflex t => HasDomEvent t (TextInput t) en where
```
like so:
```haskell
  ti <- textInput def
  domEvent Dblclick ti
```
and there are convenience functions for working with `keypress`, `keydown` and `keyup` `Events`:
```haskell
  ti <- textInput def
  keypress Enter ti
```

<div id="exercise-textInput"></div>
