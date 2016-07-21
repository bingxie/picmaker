$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  if ($('.dropzone').length) {
    var dropzone = new Dropzone (".dropzone", {
      maxFilesize: 25, // set the maximum file size to 25 MB
      paramName: "picture[file_name]", // Rails expects the file upload to be something like model[field_name]
      addRemoveLinks: false // don't show remove links on dropzone itself.
    });

    dropzone.on("success", function(file) {
      console.log(file);
      // this.removeFile(file);
    });
  }
});
