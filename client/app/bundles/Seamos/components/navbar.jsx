import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';
import FacebookLogin from '../containers/facebookLoginContainer';
import ProfileButton from '../containers/profileButtonContainer';
import LogoutButton from '../containers/logoutButtonContainer';

const Menu = () => (
  [<li key='1' >
    <ProfileButton />
  </li>,
  <li key='2' >
    <LogoutButton />
  </li>]
);

function profile() {
    return (
      [<li key='1' >
        <ProfileButton />
      </li>,
      <li key='2' >
        <LogoutButton />
      </li>]
    );
}

const Navbar = ({ session, user }) => (
  <header
    id='navbar-client'
    className='navbar navbar-fixed-top navbar-transparent'
    role='banner'
  >
    <div id="client-navbar" className='container'>
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
          <ul className='nav navbar-nav navbar-right navbar-options'>
            <li><Link to='/tags'> Temas </Link></li>
            <li><Link to='/closed-polls'> Resultados </Link></li>
            <li><Link to='/'> ¿COMO LO HACEMOS? </Link></li>
            {session.authenticityToken && Object.keys(user).length !== 0 ?
              profile() : <li> <FacebookLogin fbclassName='nav-fb' fbText='CONÉCTATE' /> </li>
            }
          </ul>
        </nav>
      </div>
    </div>
  </header>
);

Navbar.propTypes = {

};

export default Navbar;
