import PropTypes from 'prop-types';
import React from 'react';
import shouldUpdate from 'recompose/shouldUpdate';
import Tag from './tag';

const Tags = ({ tags, action }) => (
    <section id='tags-component'>
      <div className='flex-container tags-box'>
        { tags.map(tag => (
            <Tag {...tag} key={tag.id} action={action} />
          ))
        }
      </div>
    </section>
);

Tags.propTypes = {
  tags: PropTypes.array.isRequired
};

const checkPropsChange = (props, nextProps) => 
    (nextProps.tags !== props.tags 
    || nextProps.tags.length !== 0);
    

export default shouldUpdate(checkPropsChange)(Tags);
