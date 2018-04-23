import React from 'react';

function calculatePercentage(count, total, name) {
    if (name == 'SI'){
        return(Math.ceil((100 * (count / total)).toFixed(1)))
    } else {
        return(Math.floor((100 * (count / total)).toFixed(1)))
    }
}
const minorThanThirteen = { backgroundColor: 'gainsboro' };
const SingleButton = ({ name, count = 0, total, closed }) => {
    const percentage = calculatePercentage(count, total, name);
    return (
        <button className="progress btn voted-button">
            <div
                className="progress-bar"
                role="progressbar"
                aria-valuenow="70"
                aria-valuemin="0"
                aria-valuemax="100"
                style={{ width: `${percentage}%`, cursor: 'default', backgroundColor: `${closed ? 'gainsboro' : 'auto'}` }}
            >
                <span id='vote-name' style={percentage < 13 ? { color: 'black' } : {}}>{ name }</span>
                <span id='percentage'>{`${percentage}%`}</span>
            </div>
        </button>
    );
};
export default SingleButton;
