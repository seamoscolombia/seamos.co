// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { NotificationContainer, NotificationManager } from 'react-notifications';


const mapStateToProps = (state) => {
    const { newsletterReducer } = state;
    return { newsletterReducer };
};

class ToasterContainer extends Component {
    componentWillUpdate(nextProps) {
      if (nextProps.newsletterReducer.message) {
        if (nextProps.newsletterReducer.valid) {
          NotificationManager.success(nextProps.newsletterReducer.message);
        } else {
          NotificationManager.error(nextProps.newsletterReducer.message);
        }
      }
    }

    render() {
        return <NotificationContainer />;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Navbar, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps)(ToasterContainer);
