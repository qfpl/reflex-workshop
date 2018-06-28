module Frontend where

import Reflex.Dom

import Util.Bootstrap
import UI
import Workshop

frontend :: (StaticWidget x (), Widget x ())
frontend = mkApp [] [] $ ui workshop
