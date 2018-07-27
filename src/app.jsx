import React from 'react';
import ImageLoader from './components/ImageLoader'
import PreviewBar from './components/PreviewBar'

export default class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      images: [],
      loading: false
    }
  }

  onLoadStart() {
    this.setState({
      loading: true
    })
  }

  onImagesLoaded(images) {
    this.setState({
      images: images,
      loading: false
    })
  }
  
  render() {
    const { images, loading } = this.state
    return (
      <div>
        <h1>Welcome to Goop!!!</h1>
        <ImageLoader
          onImagesLoaded={this.onImagesLoaded.bind(this)}
          onLoadStart={this.onLoadStart.bind(this)}
        />
        <PreviewBar loading={loading} images={images}/>
      </div>
    )
  }
}
