// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
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
            className={'nav-with-background'}
            name={'SALIR'}
        />);
    }
}

export default withRouter(connect(null, mapDispatchToProps)(ProfileButtonContainer));
