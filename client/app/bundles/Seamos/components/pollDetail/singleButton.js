import React from 'react';

const SingleButton = (props) => (
    <button onClick={props.onClick} className='btn single-button'>
        { props.name }
    </button>
);
export default SingleButton;
