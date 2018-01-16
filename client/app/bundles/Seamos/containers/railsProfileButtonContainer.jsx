// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import ProfileButton from '../components/profile/profileButton';
import { URL } from '../constants';


const mapStateToProps = (state) => {
    const { user } = state;
    return { user };
};
class ProfileButtonContainer extends Component {
    goToProfile() {
        location.href = `${URL}/#/profile`
    }
    render() {
        return (<ProfileButton
            action={this.goToProfile.bind(this)}
            className={'nav-with-background'}
            name={'TÚ PERFIL'}
            user={this.props.user}
        />);
    }
}

export default connect(mapStateToProps)(ProfileButtonContainer);
