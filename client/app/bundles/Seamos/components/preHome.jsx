import React from 'react';
import { Link } from 'react-router-dom';
import InputContainer from '../containers/inputContainer';

const preHome = ({ session, inputReducer, subscribeNewsletter, newsletterReducer }) => (
  <span style={{'overflow': 'visible'}}>
    <div id="prehomepage" className='flex-container'>
      <section className='image-buttons-container'>
        <div className= 'title'>
          <h3>
            NUESTROS PROYECTOS
          </h3>
        </div>
        <Link to='/home'>
          <div className='image-btn left'></div>
        </Link>
        <a href="http://sifuerapresidente.co" target='_blank'>
          <div className='image-btn right'></div>
        </a>
      </section>
      <section className='mid-section-container'>
        <div className='fist'>
        </div>
        <div className='right-side'>
          <div className='title'> ¿ CÓMO LOGRAMOS EL CAMBIO ?</div>
          <div className='caption'>
            <h3> Poder Ciudadano </h3>
            <p> Involucramos a los ciudadanos en procesos de decisión política
            para que hagan valer su voto en los espacios democráticos. </p>
          </div>
          <div className='caption'>
            <h3> Compromiso Político </h3>
            <p> Vinculamos a los políticos para que se comprometan a acatar 
            las desiciones de sus votantes </p>
          </div>
        </div>
      </section>
      <section className='bottom-section-container'>
        <div className='title' id='who-are-we'>
          ¿ Quiénes SOMOS ?
        </div>
        <div className='caption'>
          SeamOS es una pĺataforma ciudadana que busca 
          <br /> 
          utilizar las TIC para actualizar la democracia.
        </div>
        <div className='buttons-container'>
          <div className='btn btn-1'>
            En un país convulsionado por la guerra e
            invadido por la corrupción, nos juntamos
            unos jóvenes para convertir la indignación
            en acción. Como parte de una generación
            transformada por las nuevas tecnologías,
            nos dimos cuenta que la solución podía estar,
            literalmente, al alcance de nuestras manos,
            y es así que creamos una herramienta que volviera
            el poder a donde realmente corresponde: al ciudadano.
            Bienvenidos a SeamOS. En Colombia, la era de la
            democracia digital ha comenzado.</div>
          <div className='btn btn-2'>
            A través de SeamOS, podremos sentar un voto de
            opinión sobre las propuestas que se presentan
            en el Concejo de Bogota. Los representantes
            han firmado voluntariamente un manifiesto con
            el cual se comprometen a suscribir sus propuestas
            en la plataforma y actuar conforme a lo manifestado
            por los ciudadanos, y aunque el voto en SeamOS no
            podrá ir en contravía de la Ley de Bancadas, sí
            podemos asegurar que valdrá para activar conversaciones,
            afectar decisiones y fortalecer la democracia.
          </div>
          <Link to='/team'>
            <div className='btn btn-3'></div>
          </Link>
          <Link to='team'>
            <div className='btn btn-4'></div>
          </Link>
        </div>
      </section>
    </div>
    <div id='homepage'>
      <div className='newsletter-container'>
        <div className='title'>
          Suscríbete a nuestro newsletter
        </div>
        <div className='newsletter'>
          <InputContainer placeholder="correo" title="subscribe" name="newsletter"
            actionCreator={() => subscribeNewsletter(inputReducer.subscribe.newsletter)}
          />
        </div>
      </div>
    </div>
  </span>
);

export default preHome;
