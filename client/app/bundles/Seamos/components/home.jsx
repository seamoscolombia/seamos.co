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
import InputContainer from '../containers/inputContainer';


const Home = ({ session, inputReducer, subscribeNewsletter, newsletterReducer }) => (
  <div id="homepage">
    <div className='background-container top'>
      <div className='flex-container top-text-container'>
        <h1 className='welcome'>El poder está<br />en tus manos</h1>
        <p className='to'>
          Presentamos la primera plataforma digital que te permite <br className='breaker' />
          incidir en las decisiones políticas de tu ciudad. <br className='breaker' />
        </p>
      </div>
    </div>
    <div id='steps-container' className="flex-container">
      <Link
        to="#"
      >
        <div className="step" style={{ height: '322px' }}>
          <div className="step-info">
            <div className="step-text">
              <span className="step-number-1">1 </span>
              &nbsp;Regístrate
            </div>
          </div>
          <div className='text'>Con un solo click en la plataforma.</div>
          <div className="step-image step-image-1" />
          {session.logged ? 
            null
            : <FacebookLogin id='fb-login-transparent' fbText='Conéctate con facebook' />
          }
        </div>
      </Link>
      <Link
        to="/tags"
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
      </Link>
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
    <div className='background-container up-mid'>
      <div className='flex-container up-mid-text-container'>
        <div id='how-to-achieve'>
          ¿Cómo logramos <br />
          el cambio?
        </div>
      </div>
    </div>
    <div id="how-facts">
      <div className="how-fact">
        <span className="title"> Poder Ciudadano </span><br />
        Involucramos a los ciudadanos en procesos de decisión
        política para que hagan valer su voto en los espacios
        democráticos.
      </div>
      <div className="how-fact">
        <span className="title"> Compromiso Político </span><br />
        Vinculamos a los políticos para que se comprometan a
        acatar las decisiones de sus votantes.
      </div>
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
    <div className='newsletter-container'>
      <div className='newsletter'>
        <div className='title'>
          Suscríbete a nuestro newsletter
        </div>
        <InputContainer placeholder="correo" title="subscribe" name="newsletter" 
          actionCreator={() => subscribeNewsletter(inputReducer.subscribe.newsletter)}
        />
        
      </div>
    </div>
  </div>
);

Home.propTypes = {
  // Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
