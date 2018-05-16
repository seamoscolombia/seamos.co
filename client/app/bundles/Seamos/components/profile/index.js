import PropTypes from 'prop-types';
import React from 'react';
import Tags from '../tags';
import Polls from '../polls';
import SelectInterests from '../../containers/selectInterestsContainer';
import MayInterestContainer from '../../containers/mayInterestContainer';

function myInterests(tags) {
  return (
    <div>
      { tags.length > 0 ?
        <section id='my-subjects' className='col-sm-12'>
          <div className='cv-title'>
            Mis temas de interés
          </div>
          <Tags tags={tags} />
        </section>
        :
        <section id='my-subjects' className='col-sm-12'>
          <div className='cv-title'>
            Mis temas de interés
          </div>
          <div className="info">
            <span>Actualmente no tienes temas seleccionados, seleccionalos en la lista de abajo</span>
            <br />
            <i className='glyphicon glyphicon-hand-down' />
          </div>
        </section>
      }
    </div>
  );
}

function selectInterests() {
  return <SelectInterests />;
}

const Profile = (props) => {
  const {
    picture, location, short_name,
    participations, tags
  } = props.user;
  const { interests } = props;
  return (
    <div id='profile'>
      <div id='profile-banner'>
        <div className='row profile--banner one'>
        </div>
      </div>
      <div className='container'>
        <header className="media">
          <div className="row profile-info-container">
            <div className="col-sm-1 media-left">
              <img src={picture} className='media-object' role='presentation' />
            </div>
            <div className="media-body col-sm-10">
              <h4 className="media-heading">{short_name}</h4>
              <h6 className="media-heading">{location}</h6>
            </div>
          </div>
        </header>
        <br />
        <div id='profile-container' className='row' >
          <div className='col-md-4'>
            {interests ? selectInterests() : myInterests(tags)}
            { selectInterests() }
          </div>
          <section className='my-participations col-sm-8'>
            <div className='open-title'>
              Participaciones recientes
            </div>
            <Polls polls={participations.polls.slice(0, 2)} />
            <div className='open-title other'>
              Otras participaciones
            </div>
            <Polls polls={participations.polls.slice(2)} type='horizontal' />
          </section>
        </div>
      </div>
      <MayInterestContainer />
    </div>
  );
};

Profile.propTypes = {
  user: { interests: PropTypes.bool.isRequired },
  user: { picture: PropTypes.string.isRequired },
  user: { location: PropTypes.string.isRequired },
  user: { full_name: PropTypes.string.isRequired },
  user: { participations: PropTypes.object.isRequired },
  user: { tags: PropTypes.array.isRequired },
};

export default Profile;
