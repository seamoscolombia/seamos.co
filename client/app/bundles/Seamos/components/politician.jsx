import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';

const moreInfoStyle = { height: 30, overflowY: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflowY: 'none' };

const Politician = (props) => {
  return (
    <div id='politician-profile'>
      <div id='profile' className='container'>
        <header className="media">
          <div className="row profile-info-container">
            <div className="col-sm-1 media-left">
              <img src={props.picture} className='media-object' role='presentation' />
            </div>
            <div className="media-body col-sm-10">
              <h4 className="media-heading">{props.short_name}</h4>
              <h5 className="media-heading organization">{props.organization}</h5>
              <h6 className="media-heading" style={props.moreInfo ? lessInfoStyle : moreInfoStyle}>{props.bio}</h6>
            </div>
          </div>
          <div style={{ textAlign: 'center' }}>
            <a onClick={props.setMoreInfo} id='plus-info'>
              {props.moreInfo ? '-INFO' : '+INFO'}
            </a>
          </div>
        </header>
        <br />
        <div id='profile-container' className='row' >
          <section className='my-participations col-sm-6'>
            <div className='title'>
              <span>PROPUESTAS VIGENTES</span>
            </div>
            <Polls polls={props.polls} />
            <div className="btn-edit-container">
              <button className="btn btn-edit"> Editar mis temas</button>
            </div>
          </section>

          <section className='my-participations col-sm-6'>
            <div className='title'>
              <span> RESULTADOS </span>
            </div>
            <Polls polls={props.closed_polls} />
          </section>
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
