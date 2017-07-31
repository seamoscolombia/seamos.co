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
        <h1 className='welcome'>Bienvenido</h1>
        <p className='to'>
          A la única plataforma ciudadana que le <br className='breaker' />
          permite incidir en las decisiones políticas en <br className='breaker' />
          tiempo real
        </p>
        <div onClick={() => window.scrollTo(0, 391)} >
          <div className='action'>
            Pasemos a la acción
          </div>
          <div className='hand-image-container'>
            <div className='hand-image'>
              <br />
              <br />
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id='how' className="flex-container">
      <div className="title">
        ¿Cómo logramos el cambio?
      </div>
      <div className="text">
        La plataforma SeamOS es un canal entre la ciudadanía y los políticos en ejercicio,
        para generar un diálogo con ellos y hacer valer la representación democrática que
        les otorgamos con nuestro voto.
      </div>
    </div>
    <div id='steps-container' className="flex-container">
      <Link
        to="#"
        onClick={() => window.scrollTo(0, 1434)}
      >
        <div className="step">
          <div className="step-info">
            <div className="step-number">1</div>
            <div className="step-text">
              Explora las propuestas publicadas según los ejes temáticos de tu interés.
            </div>
            <div className="step-image step-image-1" />
          </div>
        </div>
      </Link>
      <a
        href="https://www.facebook.com/seamoscolombia/"
        target='_blank'
        rel='noopener noreferrer'
      >
        <div className="step">
          <div className="step-info">
            <div className="step-number">2</div>
            <div className="step-text">
               Registrarte, vota y da tu opinión. El político frente a la
               propuesta será notificado.
            </div>
          </div>
          <div className="step-image step-image-2" />
        </div>
      </a>
      {/* <<<< is bad*/ }
      <Link
        to="#"
        onClick={() => window.scrollTo(0, 2050)}
      >
        <div className="step">
          <div className="step-info">
            <div className="step-number">3</div>
            <div className="step-text">
              Participa en las discusiones en torno a las propuestas que te
              interesan y aporta para fortalecerlas y lograr que se cumplan
            </div>
          </div>
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
          ¿De qué <br className='breaker' />
          quieres hablar?
        </h1>
      </div>
    </div>
    <div className="mid-paragraph">
      ¿En qué estás pensando ahora? <br />
      Encuentra las propuestas vigentes <br />
      de acuerdo a tus intereses
    </div>
    <Tags />
    <div className='background-container down'>
      <div className='flex-container down-text-container'>
        <div id='featured-polls-title'>
          PROPUESTAS DESTACADAS
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
