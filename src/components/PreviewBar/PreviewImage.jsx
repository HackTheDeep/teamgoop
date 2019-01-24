import React from 'react'
import PropTypes from 'prop-types'
import ClassNames from 'classnames'

class PreviewImage extends React.Component {
  onClick(event) {
    this.props.onImageClick(this.props.index)
  }

  render() {
    const { path, isSelected, tiffData } = this.props
    const classNames = ClassNames('preview-image', {'preview-image-selected': isSelected})
    return (
      <div>
        <img
          width='100px'
          className={classNames} 
          src={tiffData}
          onClick={this.onClick.bind(this)}
        />
      </div>
    )
  }
}

PreviewImage.propTypes = {
  path: PropTypes.string.isRequired,
  isSelected: PropTypes.bool.isRequired,
  index: PropTypes.number.isRequired,
  onImageClick: PropTypes.func.isRequired
}

export default PreviewImage