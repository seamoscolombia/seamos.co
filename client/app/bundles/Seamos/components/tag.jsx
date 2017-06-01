import PropTypes from 'prop-types';
import React from 'react';

const Tag = ({ id, name, tag_image, tag_icon, tag_color }) => (
  <div id='tag-component'>
    <div className="tag-image">
      <img alt={name} src={tag_image} />
    </div>
    <div className="tag-icon">
      <img alt={name} src={tag_icon} />
    </div>
    <div className="tag-name">{name}</div>
  </div>
);

Tag.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  tag_image: PropTypes.string.isRequired,
  tag_icon: PropTypes.string.isRequired,
  tag_color: PropTypes.string.isRequired
};

export default Tag;
