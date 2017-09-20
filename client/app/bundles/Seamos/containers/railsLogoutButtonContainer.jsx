// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import ProfileButton from '../components/profile/profileButton';
import { resetSession } from '../actions';

const mapDispatchToProps = { resetSession };

class ProfileButtonContainer extends Component {
    logout() {
        this.props.resetSession(this.props.pol);
    }
    render() {
        return (<ProfileButton
            action={this.logout.bind(this)}
            className={'nav-fb nav-fb-logout'}
            name={'Logout'}
        />);
    }
}

export default connect(null, mapDispatchToProps)(ProfileButtonContainer);
