// Simple example of a React "smart" component
import React, { Component } from 'react';
import Terms from './../components/terms';

class TermsContainer extends Component {
    render() {
        return <Terms />;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Navbar, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default TermsContainer;
