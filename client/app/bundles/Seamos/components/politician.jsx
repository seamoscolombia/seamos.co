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
          <div className='col-md-2 col-12 picture-wrapper-wrapper'>
            <div className='picture-wrapper'>
              <img src={props.picture} alt='politician' />
            </div>
          </div>
          <div className='col-md-8 basic-info'>
            <div className='basic-info-wrapper'>
              <div className=''>
                <h1> {props.short_name} </h1>
              </div>
              <div className=''>
                <h2> {props.organization} </h2>
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
              <div className='major-representation-localities'>
                {props.localities}
              </div>
              <div className='cv-subtitle'>
                Otros periodos electo
              </div>
              <div className='without-image'>
                {props.other_periods}
              </div>
              <div className='cv-subtitle'>
                Comisión
              </div>
              <div className='without-image'>
                {props.commission}
              </div>
            </div>

          </div>
          <div className='col-md-8'>
            <div className='row'>
              <div className='col-md-12'>
                <h2 className='hide-on-desktop'> Biografía </h2>
                <td dangerouslySetInnerHTML={{ __html: props.bio }} />
              </div>
            </div>
            <div className='row'>
              <div className='col-md-12'>
                <h1> Propuestas </h1>
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
