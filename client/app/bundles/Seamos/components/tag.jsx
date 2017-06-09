import PropTypes from 'prop-types';
import React from 'react';

function hasAction(action, props) {
  if (action) {
    return action(props);
  }
}
const Tag = (props) => {
  const { id, name, image, icon, color, action, selectedTagClass } = props;
  return (
    <div 
      id='tag-component' 
      className={`${selectedTagClass}`} 
      onClick={() => hasAction(action, props)} 
    >
      <div className="tag-image">
        <img alt={name} src={image} />
      </div>
      <div className="tag-icon">
        <img alt={name} src={icon} />
      </div>
      <div className="tag-name">{name}</div>
    </div>
  );
};

Tag.propTypes = {
  id: PropTypes.number.isRequired,
  goTo: PropTypes.func,
  name: PropTypes.string.isRequired,
  image: PropTypes.string.isRequired,
  icon: PropTypes.string.isRequired,
  color: PropTypes.string.isRequired
};

export default Tag;
