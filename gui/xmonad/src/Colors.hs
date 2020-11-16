module Colors where


myFgColor, myBgColor :: String
myFgColor           = "#aaaaaa"
myBgColor           = "#222222"

myHlFgColor, myHlBgColor :: String
myHlFgColor         = myFgColor
myHlBgColor         = "#93d44f"

myAcBorderColor, myInBorderColor :: String
myAcBorderColor     = myCurrWsBgColor
myInBorderColor     = "#555753"

myCurrWsBgColor, myCurrWsFgColor :: String
myCurrWsBgColor     = myHlBgColor
myCurrWsFgColor     = myBgColor

myVisWsFgColor, myVisWsBgColor :: String
myVisWsFgColor      = myBgColor
myVisWsBgColor      = "#c8e7a8"

myHidWsFgColor :: String
myHidWsFgColor      = "#ffffff"

myHidEmpWsFgColor :: String
myHidEmpWsFgColor   = "#8f8f8f" 

myUrgentWsBgColor :: String
myUrgentWsBgColor   = "#ff6565"

myTitleFgColor :: String
myTitleFgColor      = myFgColor

myUrgHintFgColor :: String
myUrgHintFgColor    = "#000000"

myUrgHintBgColor :: String
myUrgHintBgColor    = myUrgentWsBgColor

zenburnFg, doomBg :: String
zenburnFg       = "#989890"
doomBg          = "#22242b"
