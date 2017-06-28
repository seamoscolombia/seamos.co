import PropTypes from 'prop-types';
import React from 'react';
import { ShareButtons, generateShareIcon } from 'react-share';
import Polls from './polls';
import { URL } from '../constants';

const shareUrl = URL === 'http://localhost:3000' ? 'seamos.herokuapp.com' : `${URL}/${window.location.hash}`;
const shareDescription = 'somos una organización que ayuda a la democracía';
const { FacebookShareButton } = ShareButtons;
const FacebookIcon = generateShareIcon('facebook');

const imgUrl = 'https://cdn.keycdn.com/img/cdn-network.svg';
const title = 'Seamos pagina home';

const PollsByTag = (props) => {
  const { image, icon, color, name } = props.tag;
  return (
    <section id='polls-component'>
      <div className='background-container' style={{ backgroundImage: `url(${image})` }}>
        <div className='icon-name-wrapper'>
          <div className='tag-icon-container'>
            <img className='tag-icon' alt='tag icon' src={icon} />
            <FacebookShareButton
              url={shareUrl}
              title={title}
              picture={imgUrl}
              description={shareDescription}
              className="network__share-button"
            >
              <FacebookIcon
                size={32}
                round
              >
                Compartir
            </ FacebookIcon>
            </FacebookShareButton>
          </div>
          <div className='tag-name'>
            <h1> {name}</h1>
          </div>
        </div>
      </div>
      <div className='polls-box'>
        {props.polls.length !== 0 ?
          <Polls {...props} /> :
          <h3> Por el momento no hay propuestas para este tema </h3>
        }
      </div>
    </section>
  );
};

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
