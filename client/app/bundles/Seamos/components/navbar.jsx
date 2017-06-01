import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';

const Navbar = () => (
      <header 
        id='navbar-client' className='navbar navbar-fixed-top navbar-inverse' role='banner'
      >
        <div className='container'>
            <div className='navbar-header'>
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
            
            <div className='navbar-inverse side-collapse in'>
                <nav className='navbar-collapse' role='navigation'>
                    <ul className='nav navbar-nav'>
                        <li><Link to='/'> Home </Link></li>
                    </ul>
                </nav>
        </div>
        </div>
    </header>
);

Navbar.propTypes = {

};

export default Navbar;
