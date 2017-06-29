import PropTypes from 'prop-types';
import React from 'react';
import Tags from '../tags';
import Polls from '../polls';
import SelectInterests from '../../containers/selectInterestsContainer';

function myInterests(tags, goToEdit) {
  return (
    <section id='my-subjects' className='col-sm-4'>
      <div className='title'>
        <span>MIS TEMAS</span>
      </div>
      <Tags tags={tags} />
      <div className="btn-edit-container">
        <button className="btn btn-edit"onClick={goToEdit}> Editar mis temas</button>
      </div>
    </section>
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
  const { interests, goToEdit } = props;
  return (
    <div id='profile' className='container'>
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
        {interests ?
          selectInterests() : myInterests(tags, goToEdit)
        }
        <section id='my-participations' className='col-sm-6'>
          <div className='title'>
            <span> MIS PARTICIPACIONES</span>
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
