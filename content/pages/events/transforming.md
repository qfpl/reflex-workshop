One of the most common tasks we have when writing FRP code is to transform the values of an `Event`.

There is a `Functor` instance for `Event` which gives us:
```haskell
(<$>) :: Reflex t => (a -> b) -> Event t a -> Event t b
```
where `Reflex` is a typeclass that contains a lot of the core `reflex`.

This output `Event` will fire in the same frames as the input `Event`, but the values will be transformed by the supplied function.

<div id="exercise-fmap"></div>

We will also be using another `Functor`-based function frequently:
```haskell
(<$) :: Reflex t => b -> Event t a -> Event t b
```

<div id="exercise-fmapConst"></div>

As an aside, if you find yourself writing
```haskell
() <$ myEvent
```
often, then you might want to use `void` instead:
```haskell
import Control.Monad (void)

void :: Reflex t => Event t a -> Event t ()
```
