import PropTypes from 'prop-types';
import React from 'react';
import Tags from '../tags';
import Polls from '../polls';
import SelectInterests from '../../containers/selectInterestsContainer';

function myInterests(tags, goToEdit) {
  return (
    <section id='my-subjects' className='col-sm-push-1 col-sm-5'>
      <div className='title'>
        <span>MIS TEMAS</span>
      </div>
      <Tags tags={tags} />
      <button onClick={goToEdit}> Editar mis temas</button>
    </section>
  );
}

function selectInterests() {
  return <SelectInterests />;
}

const Profile = (props) => {
  const {
    picture, location, full_name,
    participations, tags
  } = props.user;
  const { interests, goToEdit } = props;
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
        {interests ?
          selectInterests() : myInterests(tags, goToEdit)
        }
        <section id='my-participations' className='col-sm-push-1 col-sm-6'>
          <div className='title'>
            <span>PARTICIPACIONES</span>
          </div>
          <Polls polls={participations.polls} />
        </section>
      </div>
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
