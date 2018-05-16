import PropTypes from 'prop-types';
import React from 'react';
import shouldUpdate from 'recompose/shouldUpdate';
import Tag from './tag';

const SelectInterests = ({ tags, action, returnToMySubjects }) => (
    <section id='my-subjects' className='col-sm-12'>
      <div className='cv-title'>
        Otros temas
      </div>
      <section id='tags-component'>
        <div className='flex-container tags-box'>
        { tags.map(tag => (
            <Tag
              key={tag.id}
              action={action}
              {...tag}
              selectedTagClass={tag.selected ? 'tag-selected' : 'tag-not-selected'}
            />
          ))
        }
        </div>
      </section>
    </section>
);

SelectInterests.propTypes = {
  tags: PropTypes.array.isRequired
};

const checkPropsChange = (props, nextProps) =>
    (nextProps.tags !== props.tags
    || nextProps.tags.length !== 0);


export default shouldUpdate(checkPropsChange)(SelectInterests);
