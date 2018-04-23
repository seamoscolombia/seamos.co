// Simple example of a React "smart" component
// import React, { Component } from 'react';
import { connect } from 'react-redux';
import preHome from '../components/preHome';

import { subscribeNewsletter } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { session, inputReducer, newsletterReducer } = state;
    return { session, inputReducer, newsletterReducer };
};

const mapDispatchToProps = { subscribeNewsletter };

export default connect(mapStateToProps, mapDispatchToProps)(preHome);
