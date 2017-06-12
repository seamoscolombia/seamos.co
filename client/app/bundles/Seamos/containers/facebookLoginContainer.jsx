import React, { Component } from 'react';
import { connect } from 'react-redux';
import FacebookLogin from 'react-facebook-login';

import { validateUserSession } from '../actions';

// const mapStateToProps = state => ({});
const mapDispatchToProps = { validateUserSession };

class FacebookLoginContainer extends Component {
  constructor(props) {
    super(props);
    this.responseFacebook = this.responseFacebook.bind(this);
  }

  responseFacebook(fbUser) {
    if (fbUser.status !== 'unknown') {
      this.props.validateUserSession(fbUser);
    }
  }

  render() {
    return (
      <FacebookLogin
        textButton={this.props.fbText || 'Login'}
        appId="1541054365966079"
        autoLoad={false}
        scope='user_location'
        fields="id,location,first_name,last_name,email,picture.width(100)"
        callback={(fbUser) => this.responseFacebook(fbUser)}
        cssClass={this.props.fbclassName || 'my-facebook-button-class'}
        icon="fa-facebook"
      />
    );
  }
}

export default connect(null, mapDispatchToProps)(FacebookLoginContainer);
