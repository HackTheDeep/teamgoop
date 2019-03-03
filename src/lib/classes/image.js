/*
 * TODO: tiff to image buffer code could live here?
 * TODO: "loadImages.js" -- probably related
*/

//import path;
var path = require('path');

class Image {
    imgPath;
   
    // Image metatdata
    filename;
    projectFolderName;
    grid;               // recording "grid" (sample plate / lattice of wires) from TEM session
    imageNumber;       // image in sequence
    dateRecorded;
    magnification;

    // Transformations
    spatial_transformations = [];
    image_transformations = [];

    constructor(imgPath) {
        this.imgPath = imgPath;

        // Store what we can derive from filename
        parse_metadata();

    }

    parse_metadata(){
        // /dir/project_folder_name/filename.tiff
        // /dir/Breviata-c11-TEMzoom/c11-b1g500Rs4-z3Ht0-i209.tiff
        chunks = path.parse(this.imgPath);

        // c11-b1g500Rs4-z3Ht0-i209
        this.filename = chunks['name'];
        // Breviata-c11-TEMzoom
        this.projectFolderName = chunks['dir'].split(path.sep).pop()

        // TODO break apart those variables more in order to fill out the
        //  metadata variables in the class definition

    }
}

//const i1 = new Image("/path/to/image.tiff");
//console.log(i1.())

export default Image;

