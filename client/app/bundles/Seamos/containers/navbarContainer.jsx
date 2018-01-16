// Simple example of a React "smart" component
import React, { Component } from 'react';
import jQuery from 'jquery';
import { connect } from 'react-redux';
import Navbar from '../components/navbar';
import { getUser, validateSession, toasterDisplay } from '../actions';
import { ToastContainer, toast } from 'react-toastify';
import { NotificationManager } from 'react-notifications';
import { LOGGED_MESSAGE } from '../constants/index';

import ToasterContainer from './toasterContainer';


const mapStateToProps = (state) => {
    const { session, user } = state;
    return { session, user };
};

const mapDispatchToProps = { getUser, validateSession, toasterDisplay };

class NavbarContainer extends Component {

    componentWillMount() {
      this.props.validateSession();
      this.props.getUser();
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
            NotificationManager.success(LOGGED_MESSAGE);
            toast(LOGGED_MESSAGE);
            this.props.toasterDisplay();
        }
    }

    render() {
        return (
            <div>
                <Navbar {...this.props} />
                <ToasterContainer />
                {/* <ToastContainer
                    position="top-right"
                    autoClose={5000}
                    hideProgressBar={false}
                    newestOnTop={false}
                    closeOnClick
                    pauseOnHover
                />
                grey with progress bar*/}
            </div>
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Navbar, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(NavbarContainer);
