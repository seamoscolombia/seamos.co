import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';
import FacebookLogin from '../containers/facebookLoginContainer';


const Navbar = ({ session }) => (
      <header 
        id='navbar-client' 
        className='navbar navbar-fixed-top navbar-transparent'
        role='banner'
      >
        <div className='container'>


            <div className='navbar-header'>
              <Link to='/' className='navbar-brand'>
                <div id='brand-logo' />       
              </Link>
              <button 
                className='navbar-toggle pull-right' 
                data-toggle='collapse-side' 
                data-target='.side-collapse' 
                data-target-2='.side-collapse-container'
                type='button'
              >
                <span className='icon-bar' />
                <span className='icon-bar' />
                <span className='icon-bar' />
              </button>
            </div>
            
            <div className='navbar-transparent side-collapse in'>
              <nav className='navbar-collapse' role='navigation'>
                <ul className='nav navbar-nav navbar-right'>
                  <li>
                    { session && session.authenticityToken ? 
                      <button className='btn btn-primary'>Perfíl</button> : 
                      <FacebookLogin fbClass='nav-fb' fbText='CONÉCTATE' />
                    }
                  </li>
                </ul>
                <ul className='nav navbar-nav navbar-right'>
                  <li><Link to='/'> ¿COMO LO HACEMOS? </Link></li>
                </ul>
              </nav>
            </div>
        </div>
    </header>
);

Navbar.propTypes = {

};

export default Navbar;
