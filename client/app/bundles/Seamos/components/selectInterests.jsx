import PropTypes from 'prop-types';
import React from 'react';
import shouldUpdate from 'recompose/shouldUpdate';
import Tag from './tag';

const SelectInterests = ({ tags, action, returnToMySubjects }) => (
    <section id='my-subjects' className='col-sm-4'>
      <div className='title'>
        <span>Seleciona tus intereses</span>
      </div>
      <section id='tags-component'>
        <div className='flex-container tags-box'>
        { tags.map(tag => (
            <Tag
              key={tag.id}
              action={action}
              {...tag}
              selectedTagClass={tag.selected ? 'tagIsSelected' : 'tagIsNotSelected'}
            />
          ))
        }
        </div>
      </section>
      <div className="btn-edit-container">
        <button className='btn btn-return' onClick={returnToMySubjects}> regresar </button>
      </div>
    </section>
);

SelectInterests.propTypes = {
  tags: PropTypes.array.isRequired
};

const checkPropsChange = (props, nextProps) =>
    (nextProps.tags !== props.tags
    || nextProps.tags.length !== 0);


export default shouldUpdate(checkPropsChange)(SelectInterests);
