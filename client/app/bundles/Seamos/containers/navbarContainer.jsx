// Simple example of a React "smart" component
import React, { Component } from 'react';
import jQuery from 'jquery';
import { connect } from 'react-redux';
import Navbar from '../components/navbar';

const mapStateToProps = (state) => {
    const { session } = state;
    return { session };
};


class NavbarContainer extends Component {
    componentDidMount() {
        const sideslider = jQuery('[data-toggle=collapse-side]');
        const sel = sideslider.attr('data-target');
        const sel2 = sideslider.attr('data-target-2');
        sideslider.click(() => {
            jQuery(sel).toggleClass('in');
            jQuery(sel2).toggleClass('out');
        });
    }

    render() {
        return <Navbar {...this.props} />;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Navbar, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps)(NavbarContainer);
