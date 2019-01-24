import React from 'react'
import PropTypes from 'prop-types'
import PreviewImage from './PreviewImage'

class PreviewBar extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      selected: 0
    }
  }

  onImageClick(index) {
    this.setState({
      selected: index
    })
  }

  render() {
    const { images, loading } = this.props
    const { selected } = this.state
    return (
      <div className='preview-bar'>
        {loading && <span>LOADING... PLEASE WAIT A FEW SECONDS...</span>}
        {images.map((image, index) => {
          return (
            <PreviewImage
              key={index}
              index={index}
              isSelected={index === selected}
              path={image.path}
              onImageClick={this.onImageClick.bind(this)}
            />
          )
        })}
      </div>
    )
  }
}

PreviewBar.propTypes = {
  images: PropTypes.arrayOf(PropTypes.object).isRequired
}

export default PreviewBar
