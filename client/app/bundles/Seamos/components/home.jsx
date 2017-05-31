import PropTypes from 'prop-types';
import React from 'react';
import FacebookLogin from '../containers/facebookLoginContainer';
import Tags from '../containers/tagsContainer';
const Home = (props) => (
  <div id="homepage">
    <div className='top-container'>
      <div className='flex-container top-text-container'>
        <h1 className='welcome'>Bienvenido</h1>
        <p className='to'>
          A la única plataforma ciudadana que le <br></br>
          permite incidir las decisiones políticas en <br></br>
          tiempo real
        </p>
        <div className='action'>
          Pasemos a la acción
        </div>
        <div className='hand-image-container'>
          <div className='hand-image'>
            <br></br>
            <br></br>
          </div>
        </div>
      </div>
    </div>
    <div className="flex-container how">
      <div className="how-title">
        ¿Cómo lo hacemos?
      </div>
      <div className="how-text">
        SeamOS es un canal entre la ciudadanía y los políticos en ejercicio, que
        busca fortalecer la democracia y transformar la política, devolviendo
        el poder a los ciudadanos, a través de un click.
      </div>
    </div>
    <div className="flex-container steps-container">
      <div className="step">
        <div className="step-info">
          <div className="step-number">1</div>
          <div className="step-text">
            Descubre propuestas de acuerdo a tus temas de interés.
          </div>
          <div className="step-image step-image-1"></div>
        </div>
      </div>
      <div className="step">
        <div className="step-info">
          <div className="step-number">2</div>
          <div className="step-text">
            Participa en las discusiones en torno a propuestas que
            te interesan y aporta para fortalecerlas.
          </div>
        </div>
        <div className="step-image step-image-2"></div>
      </div>
      <div className="step">
        <div className="step-info">
          <div className="step-number">3</div>
          <div className="step-text">
            si quieres ir más allá, regístrate con fácebook y vota
            y dile al político si crees o no en esa propuesta.
          </div>
        </div>
        <div className="step-image step-image-3"></div>
      </div>
    </div>
    <div className="fb-button-container">
      <div className="one-click"> Sin registros, solo un click </div>
      <FacebookLogin />
    </div>
    <Tags />
  </div>
);

Home.propTypes = {
  Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
