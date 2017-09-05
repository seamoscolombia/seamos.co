// Simple example of a React "smart" component
import React, { Component } from 'react';
import jQuery from 'jquery';
import { connect } from 'react-redux';
import Navbar from '../components/navbar';
import { validateSession, toasterDisplay } from '../actions';

import { ToastContainer, toast } from 'react-toastify';
import { LOGGED_MESSAGE } from '../constants';

const mapStateToProps = (state) => {
    const { session, user } = state;
    return { session, user };
};

const mapDispatchToProps = { validateSession, toasterDisplay };

class NavbarContainer extends Component {

    componentWillMount() {
      this.props.validateSession();
    }

    componentDidMount() {
        const sideslider = jQuery('[data-toggle=collapse-side]');
        const sel = sideslider.attr('data-target');
        const sel2 = sideslider.attr('data-target-2');
        const body = document.getElementsByTagName('body')[0];

        sideslider.click((e) => {
            e.stopPropagation();
            jQuery(sel).toggleClass('in');
            jQuery(sel2).toggleClass('out');
        });
        body.addEventListener('click', () => {
            jQuery(sel).removeClass('out');
            jQuery(sel).addClass('in');
        });
    }

    componentWillUpdate(nextProps) {
        if (nextProps.session.logged && !nextProps.session.display) {
            toast(LOGGED_MESSAGE);  
            this.props.toasterDisplay();
        }
    }

    render() {
        return (
            <div>
                <Navbar {...this.props} />
                <ToastContainer 
                    position="top-right"
                    autoClose={5000}
                    hideProgressBar={false}
                    newestOnTop={false}
                    closeOnClick
                    pauseOnHover
                />
            </div>
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Navbar, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(NavbarContainer);
