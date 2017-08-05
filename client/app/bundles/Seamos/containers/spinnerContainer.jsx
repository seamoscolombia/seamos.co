// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Spinner from '../components/spinner';
import { showSpinner, hideSpinner } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { isFetching } = state;
    return { isFetching };
};

const mapDispatchToProps = { showSpinner, hideSpinner };

class SpinnerContainer extends Component {
    // constructor(props) {
    //     super(props);
    //     this.isFetching = true;
    // }

    render() {
      const { isFetching } = this.props;
      console.log('is fetching ? ', isFetching);
      if (isFetching) {
          return <Spinner isFetching={isFetching} />;
      }
      return null;
    }
}
SpinnerContainer.defaultProps = {
  isFetching: true
};
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(SpinnerContainer);
