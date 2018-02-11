# teamgoop
An entry for [Iron out the kinks](https://github.com/amnh/HackTheDeep/wiki/Iron-Out-the-Kinks)

The idea for this app was to help streamline the process of turning a series of cross-sectional images into a set of curved lines in 3D space.

## Processing
All of the [Processing](https://processing.org/) .pde files are located in the `processing_mockup` directory and can be run independantly of any of the Node/Electron stuff. There is also a set of sample images in the `processing_mockup/data` directory, which can be used to test the app.

Check out the "3dmode" branch to see a version that includes a 3D view of the curves. At the moment, this branch is incompatible with the Electron app.

## Electron
This project also includes an [Electron](https://electronjs.org/) app that uses [Processing.js](http://processingjs.org/)
If you want to run the Electron app, run `npm install` and `npm start`.

At the moment the Electron app UI is very incomplete, and the only interactable elements are the "Load Images" button and the canvas. 

## The Design
To see our vision of what a fully-featured app might look like, check out the sketch files in the design folder.