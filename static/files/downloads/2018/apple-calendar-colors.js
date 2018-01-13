const colorTools = {
  light: {
    text: "#a8a8a8",
    background: "#f8f8f8"
  },
  dark: {
    text: "#000000",
    background: "#bababa"
  },
  backgrounds: {
    "#a2845e": "#e0d3c1"
  },
  isLight: function(h, s, v) {
    return v > 0.6 && s < 0.1
  },
  isDark: function(h, s, v) {
    return v < 0.3
  },
  isGray: function(h, s, v) {
    return s < 0.1
  },
  bgBrightness: function(h, s, v) {
    return Math.min(v * 1.5, 1)
  },
  toColorPart: function(c) {
    c > 255 && (c = 255);
    const t = c.toString(16);
    return c < 16 ? "0" + t : t
  },
  PARSE_COLOR_RGBRE: /^rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/i,
  PARSE_COLOR_HEXRE: /^\#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$/,
  parseColor: function(color) {
    let result = "#";
    let m;
    if (m = this.PARSE_COLOR_RGBRE.exec(color)) {
      for (let t = 1; t <= 3; t++) { 
        result += this.toColorPart(Math.max(0, Math.min(255, parseInt(m[t], 0))));
      }
      return result;
    }
    if (m = this.PARSE_COLOR_HEXRE.exec(color)) {
      if (m[1].length == 3) {
        for (let t = 0; t < 3; t++) {
          result += m[1].charAt(t) + m[1].charAt(t);
        }
        return result
      }
      return "#" + m[1]
    }
    return '#000000';
  },
  expandColor: function(c) {
    let t, n, r, i;
    rgb = this.parseColor(c);
    if (rgb) {
      const r = parseInt(rgb.slice(1, 3), 16);
      const g = parseInt(rgb.slice(3, 5), 16);
      const b = parseInt(rgb.slice(5, 7), 16);
      return [r, g, b];
    }
  },
  convertHsvToHex: function(h, s, v) {
    const angle = h == 1 ? 0 : Math.floor(h * 6);
    const u = h == 1 ? 0 : h * 6 - angle;
    const a = v * (1 - s);
    const f = v * (1 - s * u);
    const l = v * (1 - s * (1 - u));
    const c = [
      [v, l, a],
      [f, v, a],
      [a, v, l],
      [a, f, v],
      [l, a, v],
      [v, a, f]
    ];
    const r = Math.round(255 * c[angle][0]);
    const g = Math.round(255 * c[angle][1]);
    const b = Math.round(255 * c[angle][2]);

    return this.parseColor("rgb(" + r + "," + g + "," + b + ")")
  },
  convertHexToHsv: function(rgb) {
    const c = this.expandColor(rgb);

    const cmax = Math.max(Math.max(c[0], c[1]), c[2]);
    const cmin = Math.min(Math.min(c[0], c[1]), c[2]);

    const s = cmax === 0 ? 0 : 1 - cmin / cmax;
    const v = cmax / 255;
    let h;
    if (cmax == cmin) {
      h = 0
    } else if (cmax == c[0]) {
      h = (c[1] - c[2]) / (cmax - cmin) / 6;
    } else if (cmax == c[1]) {
      h = (c[2] - c[0]) / (cmax - cmin) / 6 + 1/3;
    } else {
      h = (c[0] - c[1]) / (cmax - cmin) / 6 + 2/3;
    }

    if (h < 0) {
      h += 1;
    } else if (h > 1) {
      h -= 1;
    }
    return [h, s, v];
  },
};


function computeTextColor(rgb) {
  const [h, s, v] = colorTools.convertHexToHsv(rgb);

  if (colorTools.isLight(h, s, v)) {
    return colorTools.light.text;
  } else if (colorTools.isDark(h, s, v)) {
    return colorTools.dark.text;
  } else {
    const rs = colorTools.isGray(h, s, v) ? 0 : Math.max(s, 0.5);
    const rv = v - 0.35;
    return colorTools.convertHsvToHex(h, rs, Math.max(rv, 0.3))
  }
}

function computeBackgroundColor(rgb) {
  if (colorTools.backgrounds[rgb]) {
    return colorTools.backgrounds[rgb];
  }

  const [h, s, v] = colorTools.convertHexToHsv(rgb);

  if (colorTools.isLight(h, s, v)) {
    return colorTools.light.background;
  } else if (colorTools.isDark(h, s, v)) {
    return colorTools.dark.background;
  } else {
    let rs = colorTools.isGray(h, s, v) ? 0 : s;
    return colorTools.convertHsvToHex(h, rs, colorTools.bgBrightness(h, s, v));
  } 
}

