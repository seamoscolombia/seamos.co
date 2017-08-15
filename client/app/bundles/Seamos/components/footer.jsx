import React from 'react';

const Footer = () => (
  <div id='client-footer'>
    <div className='logo-container'>
      <div className='logo-background'>
        <div className='logo'>
          <br />
          <br />
        </div>
        <div id='who-are-we'>
          <span id='footer-social-icons-container'>
            <span id='who-text' > QUIÉNES SOMOS </span>
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
