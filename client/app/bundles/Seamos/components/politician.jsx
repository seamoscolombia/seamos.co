import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';

const moreInfoStyle = { height: 30, overflowY: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflowY: 'none' };

const Politician = (props) => {
  return (
    <div id='politician-profile'>
      <div id='top-color-banner' />
      <div id='profile' className='container'>
        <div className='row top'>
          <div className='col-md-2'>
            <div className='picture-wrapper'>
              <img src={props.picture} alt='politician' />
            </div>
          </div>
          <div className='col-md-8 basic-info'>
            <div className='basic-info-wrapper'>
              <div className=''>
                <h1> {props.short_name} </h1>
              </div>
              <h2 className=''>
                {props.birthplace}, {props.age}
              </h2>
              <div className=''>
                <h1> {props.organization} </h1>
              </div>
            </div>
          </div>
          <div className='col-md-2'>
          </div>
        </div>
        <div className='row mid'>
          <div className='col-md-4'>
            <div className='cv-title'>
              Formación
            </div>
            <div className='further-studies'>
              <td dangerouslySetInnerHTML={{ __html: props.further_studies }} />
            </div>
            <div className='cv-title'>
              Carrera Política
            </div>
            <div className='career'>
              <div className='cv-subtitle'>
                Votos conseguidos
              </div>
              <div className='achieved-votes'>
                {props.last_vote_count}
              </div>
              <div className='cv-subtitle'>
                Las dos localidades con mayor representación
              </div>
              <div className='achieved-votes'>
                {props.localities}
              </div>
              <div className='cv-subtitle'>
                Organizaciones sociales que representa
              </div>
              <p> {props.represented_organizations}</p>
            </div>

          </div>
          <div className='col-md-8'>
            <div className='row'>
              <div className='col-md-12'>
                <h2> Biografía </h2>
                <p> {props.bio} </p>
              </div>
            </div>
            <div className='row'>
              <div className='col-md-12'>
                <h2> Comisión: {props.commission} </h2>
                <p> {props.initiatives} </p>
              </div>
            </div>
            <div className='row'>
              <div className='col-md-12'>
                <h1> Propuestas Abiertas </h1>
                <Polls polls={props.polls} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

Politician.propTypes = {
        picture: PropTypes.string.isRequired,
        id: PropTypes.number.isRequired,
        full_name: PropTypes.string.isRequired,
        short_name: PropTypes.string.isRequired,
        organization: PropTypes.string,
        bio: PropTypes.string,
        moreInfo: PropTypes.bool,
        polls: PropTypes.array.isRequired,
        closed_polls: PropTypes.array.isRequired
};

export default Politician;
