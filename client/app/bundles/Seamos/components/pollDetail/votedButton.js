import React from 'react';

function calculatePercentage(count, total) {
    return (
      Math.floor(100 * (count / total))
    );
}
const minorThanThirteen = { backgroundColor: 'gainsboro' };
const SingleButton = ({ name, count = 0, total }) => {
    const percentage = calculatePercentage(count, total);
    return (
        <button className="progress btn voted-button">
            <div
                className="progress-bar"
                role="progressbar"
                aria-valuenow="70"
                aria-valuemin="0"
                aria-valuemax="100"
                style={{ width: `${percentage}%`, cursor: 'default' }}
            >
                <span id='vote-name' style={percentage < 13 ? { color: 'black' } : {}}>{ name }</span>
                <span id='percentage'>{`${percentage}%`}</span>
            </div>
            <span className="tooltiptext"> Si aún no has votado, actualiza la página <br /> para ver las opciones</span>
        </button>
    );
};
export default SingleButton;
