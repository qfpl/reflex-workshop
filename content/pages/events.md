
The first type that we will use will be `Event`:
```haskell
data Event t a 
```

The semantics are often expressed as:
```haskell
Event t a ~ [(t, a)]
```
which roughly means that an `Event` of type `a` is equivalent to a list of pairs of times and values of type `a`.

The time in this case is abstract, although you can think of the time values as being distinct and increasing.
The moments of time at which `Event`s occur are often referred to as frames or transactions.
For the most part, each `Event` that is triggered by `IO` occurs in its own frame and any changes to the FRP system caused by that `Event` will not happen until the next frame.

Some example of `Event`s are:

- `eButtonPress       :: Event t ()` 
- `eTimeout           :: Event t ()` 
- `eChangeIsAdminUser :: Event t Bool`

In a more traditional setting, if we needed to check whether a button was pressed at different times in an application or in different applications states we might poll for the button press.

In an FRP system our `Event`s represent all of the occurrences of the `Event` in the application.
In some senses `Event`s are a bit like an Observer pattern from the OO world, but upgraded to be more composable.

One side-effect of having to deal with all of the occurrences of each `Event` is that it forces us to think about the various edge-cases that might effect when or whether are interested in an `Event`.

We'll be looking at the various tools we have to detect and deal with those conditions in this section.

