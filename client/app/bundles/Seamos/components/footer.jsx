import React from 'react';
import { Link } from 'react-router-dom';

const Footer = () => (
  <div id='client-footer'>
    <div className='hide-on-desktop-terms'>
      <Link
        to='/terms'
      >
        <span id='who-text-mobile' > TÉRMINOS Y CONDICIONES </span>
      </Link>
    </div>
    <div className='logo-container'>
      <div className='logo-background'>
        <div className='logo'>
          <br />
          <br />
        </div>
        <div id='who-we-are'>
          <span id='footer-social-icons-container'>
            <Link
              to='/terms'
            >
              <span id='who-text' > TÉRMINOS Y CONDICIONES </span>
            </Link>
            <span className='circle-separator'>  &#9679; </span>
            <a
              className='footer-social-icon'
              href="https://www.facebook.com/seamoscolombia/"
              target='_blank'
              rel='noopener noreferrer'
            >
              <i className="fa fa-facebook" aria-hidden="true" />
            </a>
            <a
              className='footer-social-icon'
              href="https://twitter.com/seamos"
              target='_blank'
              rel='noopener noreferrer'
            >
              <i className="fa fa-twitter" aria-hidden="true" />
            </a>
            <a
              className='footer-social-icon'
              href="https://www.instagram.com/seamoscolombia/"
              target='_blank'
              rel='noopener noreferrer'
            >
              <i className="fa fa-instagram" aria-hidden="true" />
            </a>
            <a
              className='footer-social-icon'
              href="https://www.youtube.com/channel/UCC8EUjRTWhzELH3_iypQQ8w"
              target='_blank'
              rel='noopener noreferrer'
            >
              <i className="fa fa-youtube" aria-hidden="true" />
            </a>
          </span>
        </div>
      </div>
    </div>
    <div className='disclaimer-container'>
      <span className='disclaimer'>Copyright 2017 SeamOS Democracia Digital</span>
    </div>
  </div>
);

export default Footer;
