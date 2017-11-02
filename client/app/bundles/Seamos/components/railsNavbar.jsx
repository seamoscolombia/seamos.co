import PropTypes from 'prop-types';
import React from 'react';
import GoogleLog from '../containers/googleLoginContainer';
import FacebookLogin from '../containers/facebookLoginContainer';
import RailsProfileButton from '../containers/railsProfileButtonContainer';
import RailsLogoutButton from '../containers/railsLogoutButtonContainer';
import { URL } from '../constants';


const Menu = () => (
  [<li key='1' >
    <RailsProfileButton />
  </li>,
  <li key='2' >
    <RailsLogoutButton />
  </li>]
);

function profile() {
    return (
      <span>
        <li style={{ display: 'inline-block' }} key='3'>
          <RailsProfileButton />
        </li>
        <span
          style={{ position: 'relative', top: '-8px', left: '-3px' }}
          className='circle-separator'
        > &#9679; </span>
      </span>
    );
}

function logout() {
    return (
      <li key='4'>
        <RailsLogoutButton />
      </li>
    );
}

const Navbar = ({ session, user }) => (
  <header
    id='navbar-client'
    className='navbar navbar-fixed-top'
    role='banner'
  >
    <div id="client-navbar" className='container'>
      <div className='navbar-header'>
        <a href={`${URL}/#`} className='navbar-brand'>
          <div id='brand-logo' />
        </a>
        <div className='hide-on-desktop only-photo'>
          {session.logged && Object.keys(user).length !== 0 ?
            profile() : 
            <div>
              <li key='11'>
                <FacebookLogin fbclassName='nav-dropdown-options' fbText='Facebook' />
              </li>
              <li key='12'>
                <GoogleLog googleClassName='nav-dropdown-options' googleText='Google' />
              </li>
            </div>
          }
        </div>
        <button
          className='navbar-toggle pull-right'
          data-toggle='collapse-side'
          data-target='.side-collapse'
          data-target-2='.side-collapse-container'
          type='button'
          style={{ top: '0' }}
        >
          <span className='icon-bar' />
          <span className='icon-bar' />
          <span className='icon-bar' />
        </button>
      </div>

      <div className='navbar-transparent side-collapse in'>
        <nav className='navbar-collapse' role='navigation'>
          <ul className='nav navbar-nav navbar-right navbar-options'>
            <div className='hide-on-desktop'>
              {session.logged && Object.keys(user).length !== 0 ?
                profile() : 
                <div>
                  <li key='5'>
                    <FacebookLogin fbclassName='nav-dropdown-options' fbText='Facebook' />
                  </li>
                  <li key='6'>
                    <GoogleLog googleClassName='nav-dropdown-options' googleText='Google' />
                  </li>
                </div>
              }
            </div>
            <li key='7'><a href={`${URL}/#/tags`}> Temas </a></li>
            <span className='circle-separator'> &#9679; </span>
            <li key='8'><a href={`${URL}/#`}> Blog </a></li>
            <span className='circle-separator'> &#9679; </span>
            <li key='9'><a href={`${URL}/#/`}> FAQS </a></li>
            <span className='circle-separator'> &#9679; </span>
            <li className="dropdown">
              <button className="nav-with-background" type="button" data-toggle="dropdown">
                ACERCA DE
                &ensp;
                &ensp;
                &ensp;
                &ensp;
                &ensp;                
              </button>
              <ul className="dropdown-menu custom--dropdown--about">
                <li><a href={`${URL}/#/team`}> Nuestro equipo </a></li>
                <li role="presentation" className="divider"></li>                
                <li><a href={`${URL}/#/team`}> Nuestros eventos </a></li>
                <li role="presentation" className="divider"></li>                
                <li><a href={`${URL}/#/politicians`}> Concejales que <br /> se unieron </a></li>
              </ul>
            </li>
            <span className='circle-separator'> &#9679; </span>
            <div className='hide-on-mobile'>
              {session.logged && Object.keys(user).length !== 0 ?
                profile() :
                <li className="dropdown">
                  <button className="nav-with-background" type="button" data-toggle="dropdown">
                    REGÍSTRATE
                    <span className="caret"></span>
                  </button>
                  <ul className="dropdown-menu custom--dropdown">
                    <li>
                      <FacebookLogin fbclassName='nav-dropdown-options' fbText='Facebook' />
                    </li>
                    <li role="presentation" className="divider"></li>
                    <li>
                      <GoogleLog googleClassName='nav-dropdown-options' googleText='Google' />
                    </li>
                  </ul>
                </li>
              }
            </div>
            {session.logged && Object.keys(user).length !== 0 ?
              logout() : <span />
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
