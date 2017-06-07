import React from 'react';

const imgStyle = { width: 25, height: 25, borderRadius: '50%', marginRight: 3 };
export default ({ action, className, name, user }) => (
    <button 
        onClick={action}
        className={`btn ${className}`}
    >
    { user ? 
        <img style={imgStyle} src={user.picture} role='presentation' /> :
        null
    }
    {name}
    </button>
);
