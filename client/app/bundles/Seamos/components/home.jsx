// import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';
// import { ShareButtons, generateShareIcon } from 'react-share';
import FacebookLogin from '../containers/facebookLoginContainer';
import Tags from '../containers/tagsContainer';
// import { PRODUCTION_URL } from '../constants';

// const shareUrl = `${PRODUCTION_URL}/${window.location.hash}`;
// const shareDescription = 'somos una organización que ayuda a la democracía';
// const { FacebookShareButton } = ShareButtons;
// const FacebookIcon = generateShareIcon('facebook');
// const imgUrl = `${PRODUCTION_URL}/assets/PARTICIPACIONES-4b76afbc5601851c4b5cf63c08a1a5a7c7b674ba643a7129e0147429d6be2d8c.png`;
// const title = 'Seamos pagina home';
import Polls from '../containers/pollsFeatureContainer';
import Featured from '../containers/pollsPageContainer';
const Home = ({ session }) => (
  <div id="homepage">
    <div className='background-container top'>
      <div className='flex-container top-text-container'>
        <h1 className='welcome'>SeamOS</h1>
        <p className='to'>
          Presentamos la primera plataforma digital que te permite <br className='breaker' />
          incidir en las decisiones políticas de tu ciudad. <br className='breaker' />
        </p>
      </div>
    </div>
    <div id='steps-container' className="flex-container">
      <Link
        to="#"
        onClick={() => window.scrollTo(0, 1434)}
      >
        <div className="step">
          <div className="step-info">
            <div className="step-text">
              <span className="step-number-1">1 </span>
              &nbsp;Regístrate
            </div>
          </div>
          <div className='text'>Con un solo click en la plataforma.</div>
          <div className="step-image step-image-1" />
        </div>
      </Link>
      <a
        href="https://www.facebook.com/seamoscolombia/"
        target='_blank'
        rel='noopener noreferrer'
      >
        <div className="step">
          <div className="step-info">
            <div className="step-text">
              <span className="step-number-2">2 </span>
              &nbsp;Explora
            </div>
          </div>
          <div className='text'>Las propuestas de acuerdo a tus temas de interés.</div>
          <div className="step-image step-image-2" />
        </div>
      </a>
      <Link
        to="#"
        onClick={() => window.scrollTo(0, 2050)}
      >
        <div className="step">
          <div className="step-info">
            <div className="step-text">
              <span className="step-number-3">3 </span>
               &nbsp;Vota
            </div>
          </div>
          <div className='text'>Para comenzar a incidir en los asuntos de tu ciudad.</div>
          <div className="step-image step-image-3" />
        </div>
      </Link>
    </div>
    <div className="fb-button-container">
      {session && session.authenticityToken ?
        <span /> :
        <div>
          <div className="one-click"> Sin registros, solo un click </div>
          <FacebookLogin fbText='Conéctate con facebook' />
        </div>
      }
    </div>
    <div className='background-container mid'>
      <div className='flex-container top-text-container'>
        <h1 className='welcome question'>
          Encuentra propuestas de <br className='breaker' />
          acuerdo a los temas <br className='breaker' />
          de tu interés
        </h1>
      </div>
    </div>
    <Tags />
    <div className='background-container down'>
      <div className='flex-container down-text-container'>
        <div id='featured-polls-title'>
          Propuestas<br />destacadas
        </div>
      </div>
    </div>
    <Featured />
  </div>
);

Home.propTypes = {
  // Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
