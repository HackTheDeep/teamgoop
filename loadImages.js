const {dialog} = require('electron').remote
const {readdir} = require('fs');

let images = [];

const loadImages = () => {
    let result = dialog.showOpenDialog({properties: ['openDirectory']})[0]
    readdir(result, function(err, items) {
        for (var i=0; i<items.length; i++) {
           images.push(result + "/" + items[i])
        }
       
    let processingInstance = Processing.instances[0];
    processingInstance.set_micrographs(images);
    });
    

}

