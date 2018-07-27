import { remote } from 'electron'
import { readdir, readFile } from 'fs'
import get from 'lodash/get'
import Promise from "bluebird";
import Tiff from 'tiff.js'

const readdirPromise = Promise.promisify(readdir)
const readFilePromise = Promise.promisify(readFile)


function loadImages() {
  Tiff.initialize({TOTAL_MEMORY: 33554432})
  const directory = get(remote.dialog.showOpenDialog({properties: ['openDirectory']}), '0')
  if (!directory) {
    return Promise.resolve()
  }
  return readdirPromise(directory)
    .then(items => {
      const images = []
      for (let item of items) {
        const path = directory + "/" + item
        images.push(readFilePromise(path).then(data => {
          return {
            path: path,
            tiffData: new Tiff({buffer: data}).toDataURL()
          }
        }))
      }
      return Promise.all(images)
    })
}

export default loadImages