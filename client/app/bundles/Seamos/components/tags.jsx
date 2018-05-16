import PropTypes from 'prop-types';
import React from 'react';
import shouldUpdate from 'recompose/shouldUpdate';
import { Link } from 'react-router-dom';
import Tag from './tag';

const Tags = ({ tags, action }) => (
    <section id='tags-component'>
      <div className='flex-container tags-box'>
        { tags.map(tag => (
          <Link 
           key={tag.id}
           to={`/tag/${tag.id}/polls`}
          >
          <Tag {...tag} key={tag.id} action={action} />
         </Link>
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
