// import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';
import FacebookLogin from '../containers/facebookLoginContainer';
import Tags from '../containers/tagsContainer';
import Polls from '../containers/pollsFeatureContainer';

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
        <div onClick= {() => window.scrollTo(0, 391)} >
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
        ¿Cómo lo hacemos?
      </div>
      <div className="text">
        SeamOS es un canal entre la ciudadanía y los políticos en ejercicio, que
        busca fortalecer la democracia y transformar la política, devolviendo
        el poder a los ciudadanos, a través de un click.
      </div>
    </div>
    <div id='steps-container' className="flex-container">
      <Link
        to="#"
        onClick= {() => window.scrollTo(0, 1434)}
      >
      <div className="step">
          <div className="step-info">
            <div className="step-number">1</div>
            <div className="step-text">
              Descubre propuestas de acuerdo a tus temas de interés.
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
              Participa en las discusiones en torno a propuestas que
              te interesan y aporta para fortalecerlas.
            </div>
          </div>
          <div className="step-image step-image-2" />
        </div>
      </a>
      <Link
        to='/tag/3/polls'
      >
        <div className="step">
          <div className="step-info">
            <div className="step-number">3</div>
            <div className="step-text">
              si quieres ir más allá, regístrate con fácebook y vota
              y dile al político si crees o no en esa propuesta.
            </div>
          </div>
          <div className="step-image step-image-3" />
        </div>
      </Link>
    </div>
    <div className="fb-button-container">
      { session && session.authenticityToken ?
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
    <div id='feature-polls'>
      <Polls />
    </div>
  </div>
);

Home.propTypes = {
  // Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
