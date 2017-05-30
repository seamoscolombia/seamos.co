import React, { Component } from 'react';
import { connect } from 'react-redux';
import FacebookLogin from 'react-facebook-login';

import { setUser } from '../actions';

// const mapStateToProps = (state) => { };

const mapDispatchToProps = { setUser };

class FacebookLoginContainer extends Component {
  constructor(props) {
    super(props);
    this.responseFacebook = this.responseFacebook.bind(this);
  }

  responseFacebook(response) {
    console.log(response);
  }

  render() {
    return (
      <FacebookLogin
        appId="1790047761280618"
        autoLoad={false}
        fields="id,first_name,last_name,email,picture"
        callback={this.responseFacebook}
        cssClass="my-facebook-button-class"
      />
    );
  }
}

export default connect(null, mapDispatchToProps)(FacebookLoginContainer);
