import PropTypes from 'prop-types';
import React from 'react';

function hasAction(action, props) {
  if (action) {
    return action(props);
  }
}
const Tag = (props) => {
  const { id, name, image, thumbnail, icon, color, action, selectedTagClass } = props;
  return (
    <div
      id='tag-component'
      onClick={() => hasAction(action, props)}
      style={{ backgroundImage: `url(${thumbnail})`, backgroundColor: color }}
    >
    
      <div className={`${selectedTagClass}`} >
        <span className="glyphicon glyphicon-ok-sign"></span>
        {/* <i className="glyphicon glyphicon-ok-sign" /> */}
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
  thumbnail: PropTypes.string.isRequired,
  icon: PropTypes.string.isRequired,
  color: PropTypes.string.isRequired
};

export default Tag;
