import PropTypes from 'prop-types';
import React from 'react';

const Politician = (props) => <h1>{JSON.stringify(props)}</h1>;

Politician.propTypes = {
        id: PropTypes.number.isRequired,
        full_name: PropTypes.string.isRequired,
        short_name: PropTypes.string.isRequired,
        organization: PropTypes.string,
        bio: PropTypes.string,
        polls: PropTypes.array.isRequired,
        closed_polls: PropTypes.array
    
};

export default Politician;
