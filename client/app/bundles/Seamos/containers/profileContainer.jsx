// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Profile from '../components/profile';
import { getUser } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { user, interests } = state;
    return { user, interests };
};

const mapDispatchToProps = { getUser };

class ProfileContainer extends Component {

    componentDidMount() {
        this.props.getUser();
    }
        
    interestsShow() {
        
    }
    render() {
        if (Object.keys(this.props.user) !== 0) {
            return <Profile {...this.props} />;
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(ProfileContainer);
