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
        appId="1790047761280618"
        autoLoad={false}
        fields="id,first_name,last_name,email,picture.type(large)"
        callback={(fbUser) => this.responseFacebook(fbUser)}
        cssClass={this.props.fbClass || 'my-facebook-button-class'}
      />
    );
  }
}

export default connect(null, mapDispatchToProps)(FacebookLoginContainer);
