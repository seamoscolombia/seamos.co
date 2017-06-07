import React from 'react';

export default ({ action, className, name }) => (
    <button 
        onClick={action}
        className={`btn ${className}`}
    >{name}
    </button>
);
