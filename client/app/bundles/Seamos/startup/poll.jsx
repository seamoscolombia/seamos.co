import React, { Component } from 'react';

import RailsNavbarContainer from '../containers/railsNavbarContainer';
import PollDetailContainer from '../containers/pollDetailContainer';
import RailsFooterContainer from '../containers/railsFooterContainer';
import Loader from '../containers/loaderContainer';

class Poll extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isLoading: true
    };
  }

  componentDidMount() {
    setTimeout(() => this.setState({ isLoading: false }), 1500);
  }

  render() {
    return (
      <div>
        { this.state.isLoading ?
          <div className="loader-container">
            <Loader />
          </div>
          : null
        }
        <RailsNavbarContainer />
        <PollDetailContainer />
        <RailsFooterContainer />
      </div>
    );
  }
}

export default Poll;
