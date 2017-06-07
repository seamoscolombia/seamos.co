// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Profile from '../components/profile';
// import { getTags } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { user } = state;
    return { user };
};

// const mapDispatchToProps = { getTags };

// class ProfileContainer extends Component {


//     render() {
//         return <Profile {...this.props} />;
//     }
// }
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps)(Profile);
