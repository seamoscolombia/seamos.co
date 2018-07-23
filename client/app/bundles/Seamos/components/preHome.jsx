import React from 'react';
import { Link } from 'react-router-dom';
import InputContainer from '../containers/inputContainer';
import { S3_BASE } from '../constants';

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
          <div className='image-btn left'>
            <img src= {S3_BASE + "seamos-btn.png"} alt=""/>
          </div>          
        </Link>
        <a href="http://sifuerapresidente.co" target='_blank'>
          <div className='image-btn right'>
            <img src= {S3_BASE + "sfp-btn.png"} alt=""/>
          </div>
        </a>
      </section>
      <section className='mid-section-container'>
        <div className='fist'>
          <img src= {S3_BASE + "fist-2.png"} alt=""/>
        </div>
        <div className='right-side'>
          <div className='title'>¿CÓMO LOGRAMOS EL CAMBIO?</div>
          <span className='caption'>
            <h3> Poder Ciudadano </h3>
            <p> Involucramos a los ciudadanos en procesos de decisión política
            para que hagan valer su voto en los espacios democráticos. </p>
          </span>
          <span className='caption'>
            <h3> Compromiso Político </h3>
            <p> Vinculamos a los políticos para que se comprometan a acatar 
            las desiciones de sus votantes </p>
          </span>
        </div>
      </section>
      <section className='bottom-section-container'>
        <div className='title' id='who-are-we'>
          ¿ Quiénes SOMOS ?
        </div>
        <div className='caption'>
          SeamOS es una plataforma ciudadana que busca 
          <br /> 
          utilizar las TIC para actualizar la democracia.
        </div>
        <div id='buttons-container'>
          <div id='btn-1' className='btn square'>
            <h3>
            	Qué pasa con tu voto
            </h3>
          </div>
          <div id='btn-2' className='btn square'>
            <h3>
            	Nuestra Historia
            </h3>
          </div>
          <div id='btn-3' className='btn square'>
            <h3>
            	Nuestro Equipo
            </h3>
          </div>
          <div id='btn-4' className='btn square'>
            <h3>
            	Socios y aliados
            </h3>
          </div>
        </div>
        <div>
          <span id='info-1' className='info'>
            A través de SeamOS, podremos sentar un voto de opinión sobre las propuestas que se presentan en el Concejo de Bogota. 
            Los representantes han firmado voluntariamente un manifiesto con el cual se comprometen a suscribir sus propuestas en 
            la plataforma y actuar conforme a lo manifestado por los ciudadanos, y aunque el voto en SeamOS no podrá ir en contravía 
            de la Ley de Bancadas, sí podemos asegurar que valdrá para activar conversaciones, afectar decisiones y fortalecer la democracia.
          </span>
          <span id='info-2' className='info'>
            En un país convulsionado por la guerra e invadido por la corrupción, nos juntamos unos jóvenes para convertir la indignación 
            en acción. Como parte de una generación transformada por las nuevas tecnologías, nos dimos cuenta que la solución podía estar, 
            literalmente, al alcance de nuestras manos, y es así que creamos una herramienta que volviera el poder a donde realmente corresponde: 
            al ciudadano. Bienvenidos a SeamOS. En Colombia, la era de la democracia digital ha comenzado.
          </span>
          <span id='info-3' className='info'>
            <div className='team-members'>
              <div>
                Actualizando.
              </div>
              {/* <div className='team-member one'>
                <div className='name'>
                  Nicolás <br className='breaker' />
                  Díaz
                </div>
                <div className='profession'>
                  Politólogo
                </div>
                <div className='role'>
                  Director
                </div>
              </div>
              <div className='team-member two'>
                <div className='name'>
                  Juan Carlos <br className='breaker' />
                  Rodríguez
                </div>
                <div className='profession'>
                  Economista
                </div>
                <div className='role'>
                  Administrativo
                </div>
              </div>
              <div className='team-member three'>
                <div className='name'>
                  Andrea <br className='breaker' />
                  Mora
                </div>
                <div className='profession'>
                  Internacionalista
                </div>
                <div className='role'>
                  Outreach Político
                </div>
              </div>
              <div className='team-member four'>
                <div className='name'>
                  David <br className='breaker' />
                  Núñez
                </div>
                <div className='profession'>
                  Politólogo
                </div>
                <div className='role'>
                  Outreach Político
                </div>
              </div>
              <div className='team-member five'>
                <div className='name'>
                  Andrés <br className='breaker' />
                  Márquez
                </div>
                <div className='profession'>
                  Abogado
                </div>
                <div className='role'>
                  Outreach Político
                </div>
              </div>
              <div className='team-member six'>
                <div className='name'>
                  Alexander <br className='breaker' />
                  Quiceno
                </div>
                <div className='profession'>
                  Ingeniero
                </div>
                <div className='role'>
                  Programación
                </div>
              </div>
              <div className='team-member seven'>
                <div className='name'>
                  Juliana <br className='breaker' />
                  Ramírez
                </div>
                <div className='profession'>
                  Publicista
                </div>
                <div className='role'>
                  Comunicaciones
                </div>
              </div>
              <div className='team-member eight'>
                <div className='name'>
                  Karen <br className='breaker' />
                  Fonseca
                </div>
                <div className='profession'>
                  Diseñadora Gráfica
                </div>
                <div className='role'>
                  Comunicaciones
                </div>
              </div> */}
            </div>
          </span>
          <span id='info-4' className='info'>
            <div className='allies row'>
              <div className='ally one col-md-6'>
              </div>
              <div className='ally two col-md-6'>
              </div>
              <div className='ally three col-md-4'>
              </div>
              <div className='ally four col-md-4'>
              </div>
              <div className='ally five col-md-4'>
              </div>
              <div className='ally six col-md-6'>
              </div>
              <div className='ally seven col-md-6'>
              </div>
            </div>
          </span>
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
