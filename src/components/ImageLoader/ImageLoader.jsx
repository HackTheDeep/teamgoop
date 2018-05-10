import React from 'react'
import { Button } from 'react'
import PropTypes from 'prop-types'
import loadImages from '../../lib/loadImages'

class ImageLoader extends React.Component {
  onClick(event) {
    this.props.onLoadStart()
    loadImages().then((images) => {
      this.props.onImagesLoaded(images)
    }).catch(error => {
      console.log(error)
    })
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
  onImagesLoaded: PropTypes.func.isRequired,
  onLoadStart: PropTypes.func.isRequired
}

export default ImageLoader