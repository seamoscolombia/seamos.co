import React from 'react';

function calculatePercentage(count, total) {
    return (
      Math.floor(100 * (count / total))
    );
}
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
                <span>{ name } {`${percentage}%`}</span>
            </div>
        </button>
    );
};
export default SingleButton;
