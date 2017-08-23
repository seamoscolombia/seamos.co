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
    <div id="client-navbar" className='container'>
      <div className='navbar-header'>
        <Link to='/' className='navbar-brand'>
          <div id='brand-logo' />
        </Link>
        <div className='hide-on-desktop only-photo'>
          {session.authenticityToken && Object.keys(user).length !== 0 ?
            profile() : <li key='11'> <FacebookLogin fbclassName='nav-fb' fbText='' /> </li>
          }
        </div>
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
            <div className='hide-on-desktop'>
              {session.authenticityToken && Object.keys(user).length !== 0 ?
                profile() : <li key='5'> <FacebookLogin fbclassName='nav-fb' fbText='REGÍSTRATE' /> </li>
              }
            </div>
            <li key='6'><Link to='/tags'> Temas </Link></li>
            <span className='circle-separator'> &#9679; </span>
            <li key='8'>
              <a
               href='http://seamos.co/quienes-somos'
               target='_blank'
               rel='noopener noreferrer'
              >
                Quiénes somos
              </a>
            </li>
            <span className='circle-separator'> &#9679; </span>
            {/*
              <li key='8' className='dropdown hide-on-mobile'>
                <a> Siguenos </a>
                <div className='dropdown-content'>
                  <a
                    className='social-icon facebook-icon'
                    href="https://www.facebook.com/seamoscolombia/"
                    target='_blank'
                    rel='noopener noreferrer'
                  >
                    <br />
                  </a>
                  <a
                    className='social-icon twitter-icon'
                    href="https://twitter.com/seamos"
                    target='_blank'
                    rel='noopener noreferrer'
                  >
                    <br />
                  </a>
                  <a
                    className='social-icon instagram-icon'
                    href="https://www.instagram.com/seamoscolombia/"
                    target='_blank'
                    rel='noopener noreferrer'
                  >
                    <br />
                  </a>
                  <a
                    className='social-icon youtube-icon'
                    href="https://www.youtube.com/channel/UCC8EUjRTWhzELH3_iypQQ8w"
                    target='_blank'
                    rel='noopener noreferrer'
                  >
                    <br />
                  </a>
                </div>
              </li>
            <li key='10' className='hide-on-desktop sidebar-social'>
              <a style={{textAlign: 'center'}}> Siguenos </a>
              <div className="social-icons-wrapper">
                <a
                  className='social-icon facebook-icon'
                  href="https://www.facebook.com/seamoscolombia/"
                  target='_blank'
                  rel='noopener noreferrer'
                >
                  <br />
                </a>
                <a
                  className='social-icon twitter-icon'
                  href="https://twitter.com/seamos"
                  target='_blank'
                  rel='noopener noreferrer'
                >
                  <br />
                </a>
                <a
                  className='social-icon instagram-icon'
                  href="https://www.instagram.com/seamoscolombia/"
                  target='_blank'
                  rel='noopener noreferrer'
                >
                  <br />
                </a>
                <a
                  className='social-icon youtube-icon'
                  href="https://www.youtube.com/channel/UCC8EUjRTWhzELH3_iypQQ8w"
                  target='_blank'
                  rel='noopener noreferrer'
                >
                  <br />
                </a>
              </div>
            </li>
          */}
            <div className='hide-on-mobile'>
              {session.authenticityToken && Object.keys(user).length !== 0 ?
                profile() : <li key='11'> <FacebookLogin fbclassName='nav-fb' fbText='Regístrate' /> </li>
              }
            </div>
            {session.authenticityToken && Object.keys(user).length !== 0 ?
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
