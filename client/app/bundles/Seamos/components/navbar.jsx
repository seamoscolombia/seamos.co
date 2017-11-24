import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';
import GoogleLog from '../containers/googleLoginContainer';
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
      <span>
        <li style={{ display: 'inline-block' }} key='3'>
          <ProfileButton />
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
        <LogoutButton />
      </li>
    );
}

const Navbar = ({ session, user }) => (
  <header
    id='navbar-client'
    className='navbar navbar-fixed-top'
    role='banner'
  >
    <div id="client-navbar">
      <div className='navbar-header'>
        <Link to='/' className='navbar-brand'>
          <div id='brand-logo' />
        </Link>
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
            <li key='7'><Link to='/tags'> Temas </Link></li>
            <span className='circle-separator'> &#9679; </span>
            <li key='8'>
              <a
              href="https://seamosit.github.io"
              rel='noopener noreferrer'
              > Blog
              </a>
            </li>
            <span className='circle-separator'> &#9679; </span>
            <li key='9'><Link to='/#'> FAQS </Link></li>
            <span className='circle-separator'> &#9679; </span>
            <li className="dropdown">
              <button className="nav-with-background about" type="button" data-toggle="dropdown">
                ACERCA DE
              </button>
              <ul className="dropdown-menu custom--dropdown--about">
                <li><Link to='/team'> Nuestro equipo </Link></li>
                <li role="presentation" className="divider"></li>
                <li><Link to='/team'> Nuestros eventos </Link></li>
                <li role="presentation" className="divider"></li>
                <li><Link to='/politicians'> Concejales que <br /> se unieron </Link></li>
              </ul>
            </li>
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
