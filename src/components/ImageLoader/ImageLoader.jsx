import React from 'react'
import { Button } from 'react'
import PropTypes from 'prop-types'
import { remote } from 'electron'
import { readdir } from 'fs'
import get from 'lodash/get'

class ImageLoader extends React.Component {
  onClick(event) {
    const directory = get(remote.dialog.showOpenDialog({properties: ['openDirectory']}), '0')
    if (!directory) {
      return
    }
    const images = []
    readdir(directory, function(err, items) {
      for (let item of items) {
        images.push({
          path: directory + "/" + item
        })
      }
      this.props.onImagesLoaded(images)
    }.bind(this))
  }

  render() {
    return (
      <button 
        className='load-images-button'
        onClick={this.onClick.bind(this)}
      >
        Load Images
      </button>
    )
  }
}

ImageLoader.propTypes = {
  onImagesLoaded: PropTypes.func.isRequired
}

export default ImageLoader