{
  convertHsvToHex: function(e, t, n) {
    var r = 0,
      i = 0,
      s = 0;
    if (n > 0) {
      var o = e == 1 ? 0 : Math.floor(e * 6),
        u = e == 1 ? 0 : e * 6 - o,
        a = n * (1 - t),
        f = n * (1 - t * u),
        l = n * (1 - t * (1 - u)),
        c = [
          [n, l, a],
          [f, n, a],
          [a, n, l],
          [a, f, n],
          [l, a, n],
          [n, a, f]
        ];
      r = Math.round(255 * c[o][0]), i = Math.round(255 * c[o][1]), s = Math.round(255 * c[o][2])
    }
    return this.parseColor("rgb(" + r + "," + i + "," + s + ")")
  },
    convertHexToHsv: function(e) {
      var t = this.expandColor(e),
        n = 0,
        r = 0,
        i = 0;
      if (t) {
        var s = Math.max(Math.max(t[0], t[1]), t[2]),
          o = Math.min(Math.min(t[0], t[1]), t[2]);
        r = s === 0 ? 0 : 1 - o / s, i = s / 255, n = s == o ? 0 : s == t[0] ? (t[1] - t[2]) / (s - o) / 6 : s == t[1] ? (t[2] - t[0]) / (s - o) / 6 + 1 / 3 : (t[0] - t[1]) / (s - o) / 6 + 2 / 3, n = n < 0 ? n + 1 : n > 1 ? n - 1 : n
      }
      return [n, r, i]
    },
    PARSE_COLOR_RGBRE: /^rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/i,
    PARSE_COLOR_HEXRE: /^\#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$/,
    expandColor: function(e) {
      var t, n, r, i;
      t = this.parseColor(e);
      if (t) return n = parseInt(t.slice(1, 3), 16), r = parseInt(t.slice(3, 5), 16), i = parseInt(t.slice(5, 7), 16), [n, r, i]
    },
    parseColor: function(e) {
      var t = 0,
        n = "#",
        r, i;
      if (r = this.PARSE_COLOR_RGBRE.exec(e)) {
        for (t = 1; t <= 3; t++) i = Math.max(0, Math.min(255, parseInt(r[t], 0))), n += this.toColorPart(i);
        return n
      }
      if (r = this.PARSE_COLOR_HEXRE.exec(e)) {
        if (r[1].length == 3) {
          for (t = 0; t < 3; t++) n += r[1].charAt(t) + r[1].charAt(t);
          return n
        }
        return "#" + r[1]
      }
      return !1
    },
    toColorPart: function(e) {
      e > 255 && (e = 255);
      var t = e.toString(16);
      return e < 16 ? "0" + t : t
    }
}
