import React from 'react';
import ImageLoader from './components/ImageLoader'
import PreviewBar from './components/PreviewBar'

export default class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      images: []
    }
  }

  onImagesLoaded(images) {
    this.setState({
      images: images
    })
    console.log(images)
  }
  
  render() {
    const { images } = this.state
    return (
      <div>
        <h1>Welcome to Goop!!!</h1>
        <ImageLoader
          onImagesLoaded={this.onImagesLoaded.bind(this)}
        />
        <PreviewBar images={images}/>
      </div>
    )
  }
}
