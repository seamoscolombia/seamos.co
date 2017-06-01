import PropTypes from 'prop-types';
import React from 'react';
import Tag from './tag';

const Tags = ({ tags }) => (
    <section id='tags-component'>
      <div className='flex-container tags-box'>
        { tags.map(tag => (
            <Tag {...tag} key={tag.id} />
          ))
        }
      </div>
    </section>
);

Tags.propTypes = {
  tags: PropTypes.array.isRequired
};

export default Tags;
