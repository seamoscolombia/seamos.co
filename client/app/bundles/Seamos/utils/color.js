class Color {
    constructor(props) {
        const { initial_time, remaining, startColor, endColor } = props;
        const startingColor = this.hexToRgb(startColor);
        const endingColor = this.hexToRgb(endColor);
        const percentage = Math.abs(1 - (remaining / initial_time)) * 100; //eslint-disable-line
        this.state = { percentage, startColor: startingColor, endColor: endingColor };
    }

    hexToRgb(hex) {
        const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
        return result ? {
            r: parseInt(result[1], 16),
            g: parseInt(result[2], 16),
            b: parseInt(result[3], 16)
        } : null;
    }

    componentToHex(c) {
        const hex = c.toString(16);
        return hex.length === 1 ? `0${hex}` : hex;
    }

    rgbToHex(r, g, b) {
        const { componentToHex } = this;
        return `#${componentToHex(r)}${componentToHex(g)}${componentToHex(b)}`;
    }

    interpolate() {
        const { startColor, endColor, percentage } = this.state;
        const r = this.getColors(startColor.r, endColor.r, 100, percentage);
        const g = this.getColors(startColor.g, endColor.g, 100, percentage);
        const b = this.getColors(startColor.b, endColor.b, 100, percentage);
        
        return this.rgbToHex(r, g, b);
    }

    getColors(startColor, endColor, steps, count) {
        const final = startColor + (((endColor - startColor) / steps) * count);

        return Math.floor(final);
    }
}

export default Color;
