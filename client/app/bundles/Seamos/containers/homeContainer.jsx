// Simple example of a React "smart" component
// import React, { Component } from 'react';
import { connect } from 'react-redux';
import Home from '../components/home';

import { subscribeNewsletter } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { session, inputReducer } = state;
    return { session, inputReducer };
};

const mapDispatchToProps = { subscribeNewsletter };

// class HomeContainer extends Component {

//     componentWillMount(){
//         this.props.getPolls();
//     }

//     render() {
//         return <Home { ...props } />
//     }
// }
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(Home);
