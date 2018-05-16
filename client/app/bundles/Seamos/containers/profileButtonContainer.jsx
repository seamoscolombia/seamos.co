// Simple example of a React "smart" component
import React, { Component } from 'react';
import { withRouter } from 'react-router-dom';
import { connect } from 'react-redux';
import ProfileButton from '../components/profile/profileButton';

const mapStateToProps = (state) => {
    const { user } = state;
    return { user };
};
class ProfileButtonContainer extends Component {
    goToProfile() {
        this.props.history.push('/profile');
    }
    render() {
        return (<ProfileButton
            action={this.goToProfile.bind(this)}
            className={'nav-with-background'}
            name={'TU PERFIL'}
            user={this.props.user}
        />);
    }
}

export default withRouter(connect(mapStateToProps)(ProfileButtonContainer));
