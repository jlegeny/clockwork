const gulp = require("gulp");
const sass = require("gulp-sass");

gulp.task("scss", () => {
  gulp.src("scss/**/*.scss")
  .pipe(sass({
    outputStyle : "compressed"
  }))
  .pipe(gulp.dest("static/css"));
});

gulp.task("watch", ["scss"], () => {
  gulp.watch("scss/**/*", ["scss"]);
});

gulp.task("default", ["watch"]);

