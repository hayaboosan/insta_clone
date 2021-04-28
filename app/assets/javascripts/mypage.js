//= require jquery3
//= require popper
//= require rails-ujs
//= require bootstrap-material-design/dist/js/bootstrap-material-design.js

function previewFileWithId(selector) {
  const target = this.event.target;
  const file = target.files[0];
  const render = new FileReader();
  render.onloadend = function () {
    selector.src = render.result;
  }
  if (file) {
    render.readAdDataURL(file);
  } else {
    selector.src = "";
  }
}
