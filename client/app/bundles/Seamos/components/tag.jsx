import PropTypes from 'prop-types';
import React from 'react';

function hasAction(action, props) {
  if (action) {
    return action(props);
  }
}
const Tag = (props) => {
  const { id, name, tag_image, tag_icon, tag_color, action } = props;
  return (
    <div id='tag-component' onClick={() => hasAction(action, props)} >
      <div className="tag-image">
        <img alt={name} src={tag_image} />
      </div>
      <div className="tag-icon">
        <img alt={name} src={tag_icon} />
      </div>
      <div className="tag-name">{name}</div>
    </div>
  );
};

Tag.propTypes = {
  id: PropTypes.number.isRequired,
  goTo: PropTypes.func,
  name: PropTypes.string.isRequired,
  tag_image: PropTypes.string.isRequired,
  tag_icon: PropTypes.string.isRequired,
  tag_color: PropTypes.string.isRequired
};

export default Tag;
