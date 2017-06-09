import PropTypes from 'prop-types';
import React from 'react';
import Tags from '../tags';
import Polls from '../polls';
import SelectInterests from '../../containers/selectInterestsContainer';

function myInterests(tags) {
  return (
     <section id='my-subjects' className='col-sm-6'>
      <div className='title'>
        <span>MIS TEMAS</span>
      </ div>
      <Tags tags={tags} />
    </section>
  );
}

function selectInterests() {
  return <SelectInterests />;
}

const Profile = (props) => {
  const {
   picture, location, full_name,
   participations, tags, interests
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
        { interests ? 
          selectInterests() : myInterests(tags)
        }
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
   interests: PropTypes.bool.isRequired,
   picture: PropTypes.string.isRequired,
   location: PropTypes.string.isRequired,
   full_name: PropTypes.string.isRequired,
   participations: PropTypes.object.isRequired, 
   tags: PropTypes.array.isRequired
};

export default Profile;
