import PropTypes from 'prop-types';
import React from 'react';

const PollDetail = ({ 
  id, title, image,
  description, objective, remainingTime,
  vote_count, user_already_voted, links,
  politician, poll_type, moreInfo
}) => (
  <div>

  </div>
);

PollDetail.propTypes = {
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  image: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  objective: PropTypes.string.isRequired,
  remainingTime: PropTypes.number.isRequired,
  vote_count: PropTypes.number.isRequired,
  poll_type: PropTypes.number.isRequired,
  user_already_voted: PropTypes.bool.isRequired,
  links: PropTypes.array.isRequired,
  politician: PropTypes.object.isRequired,
  moreInfo: PropTypes.bool.isrequired
};

export default PollDetail;
