import PropTypes from 'prop-types';
import React from 'react';
import Tags from '../tags';
import Polls from '../polls';

const Profile = (props) => {
  const {
   picture, location, full_name,
   participations, tags
  } = props.user;
  return (
    <div id='profile' className='container'>
      <header className="media">
        <div className="media-left">
          <img src={picture} className='media-object' role='presentation' />
        </div>
        <div className="media-body">
          <h4 className="media-heading">{full_name}</h4>
        </div>
      </header>
      <br />
      <div id='profile-container' className='row' >
        <section id='my-subjects' className='col-sm-6'>
          <div className='title'>
            <span>MIS TEMAS</span>
          </ div>
          <Tags tags={tags} />
        </section>
        <section id='my-participations' className='col-sm-6'>
          <div className='title'>
            <span>PARTICIPACIONES</span>
          </ div>
          <Polls polls={participations.polls} />
        </section>
      </div>
    </div>
  );
};

Profile.propTypes = {
   picture: PropTypes.string.isRequired,
   location: PropTypes.string.isRequired,
   full_name: PropTypes.string.isRequired,
   participations: PropTypes.object.isRequired, 
   tags: PropTypes.array.isRequired
};

export default Profile;
