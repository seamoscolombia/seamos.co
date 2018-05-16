import React, { Component } from 'react';
import { connect } from 'react-redux';
import GoogleLogin from 'react-google-login';
import { GOOGLE_APP_ID } from '../constants';
import { validateUserSession, validateSession } from '../actions';

const mapDispatchToProps = { validateUserSession, validateSession };


class GoogleLog extends Component {
  constructor(props) {
    super(props);

    this.responseGoogle = this.responseGoogle.bind(this);
  }

  responseGoogle(googleUser) {
    this.props.validateUserSession(googleUser)
    .then(() => {
      this.props.validateSession();  
    })
    .catch(err => {
      console.log(err);
    });
  }

  render() {
    return (
      <div>
        <GoogleLogin
          clientId={GOOGLE_APP_ID}
          buttonText={this.props.googleText || 'Login'}
          onSuccess={this.responseGoogle}
          onFailure={this.responseGoogle}
          className={this.props.googleClassName}
        />
      </div>
    );
  }

}

export default connect(null, mapDispatchToProps)(GoogleLog);