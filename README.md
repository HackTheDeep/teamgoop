## Gooper\*

This is the repo for Gooper, a tool to reconstitute 3d volumes from micrographs (Electron microscope photos) of thin slices of dehydrated protist cells.

This is all to assist [Aaron Heiss](https://www.amnh.org/our-research/invertebrate-zoology/staff/postdoctoral-fellows/aaron-a.-heiss-ph.d/) in his work though we're interested to see if others will find this useful!

\* Name subject to name change!


## The plan
We're going to combine our two prototypes together along with some new application flows developed in some meetings into a standalone electron app.

We're going to be performing distributed development, design and testing using github for code and issue tracking.


## The Design
To see our vision of what a fully-featured app might look like, check out the sketch files in the design folder.


## History
This application originally began it's life as an entry for the ['Iron out the kinks'](https://github.com/amnh/HackTheDeep/wiki/Iron-Out-the-Kinks) challenge at the 2018 AMNH "Hack the Deep" hackathon.  There were a few earlier iterations that can still be accessed on other branches of this repo.

### Processing prototype
All of the [Processing](https://processing.org/) .pde files are located in the `processing_mockup` directory and can be run independently of any of the Node/Electron stuff. There is also a set of sample images in the `processing_mockup/data` directory, which can be used to test the app.

Check out the "3dmode" branch to see a version that includes a 3D view of the curves. At the moment, this branch is incompatible with the Electron app.

### Electron prototype
This project also includes an [Electron](https://electronjs.org/) app that uses [Processing.js](http://processingjs.org/)
If you want to run the Electron app, run `npm install` and `npm start`.

At the moment the Electron app UI is very incomplete, and the only interactable elements are the "Load Images" button and the canvas.


