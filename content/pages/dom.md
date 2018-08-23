
Now we'll start working with the DOM.
This means that we'll be starting to work with `reflex-dom` as well as `reflex` itself.

When we manipulate the DOM we work inside of a builder monad, and we access this builder monad through the `DomBuilder` typeclass.

There is also a collection of typeclass constraints called `MonadWidget` that includes all of the typeclasses we have seen so far (and a few which we'll see before too long), which can be really useful.

The widgets get added to the page in the order that they appear in our code.
This adds another reason for `RecursiveDo` to enter the scene: sometimes the elements we won't have a cycle in our network, but the order that the network is laid out in will be different to the order in which we connect the `Event`s and `Behavior`s.

The simplest thing we can add to the DOM is some text:
```haskell
text    :: DomBuilder t m 
        => Text 
        -> m ()
```

We _could_ do things like:
```haskell
myThing :: MonadWidget t m => m ()
myThing = do
  text "<div>"
  text "I made a thing!"
  text "</div>"
```
but we can do better than that...
