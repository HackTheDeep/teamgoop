import { remote } from 'electron'
import { readdir, readFile } from 'fs'
import get from 'lodash/get'
import Promise from "bluebird";
import Image from './classes/image';

const readdirPromise = Promise.promisify(readdir)
const readFilePromise = Promise.promisify(readFile)


function loadImages() {
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
          return new Image(path)
        }))
      }
      return Promise.all(images)
    })
}

export default loadImages
