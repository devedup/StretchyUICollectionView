# StretchyUICollectionView

A UICollectionView with a stretchy zoomy top image. 

I want my top cell to stretch and zoom its image content instead of revealing the collection view background. I also want it to behave normally when I scroll up, and not squash into itself.

## How it works

It alters the constraints of the cell at index 0, and resets them when the cell goes offscreen.

* Removes the current top constraint of the image view to the cell
* Pins a new constraint from the image view to the top layout guide
* Pins a new constraint from the image view to the top of the collection view
* Disables clipping on cell
* Sets content mode of image view to aspect fill - which does the stretching

## Features

* It's written in Swift 
* Using a storyboard to setup the UICollectionView and Cell 
* The demo images are in an assets catalog.
* It uses autolayout.

![Preview](https://raw.github.com/devedup/StretchyUICollectionView/master/StretchyGif.gif)
