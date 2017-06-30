// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import ProfileButton from '../components/profile/profileButton';
import { resetSession } from '../actions';

const mapDispatchToProps = { resetSession };

class ProfileButtonContainer extends Component {
    logout() {
        this.props.resetSession();
    }
    render() {
        return (<ProfileButton
            action={this.logout.bind(this)}
            className={'nav-fb'}
            name={'Logout'}
        />);
    }
}

export default withRouter(connect(null, mapDispatchToProps)(ProfileButtonContainer));
