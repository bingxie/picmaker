$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  if ($('.dropzone').length) {
    var dropzone = new Dropzone (".dropzone", {
      maxFilesize: 25, // set the maximum file size to 25 MB
      paramName: "picture[file_name]", // Rails expects the file upload to be something like model[field_name]
      addRemoveLinks: false, // don't show remove links on dropzone itself.
      // previewsContainer: ".dropzone-previews",
      dictDefaultMessage: '拖拽图片到这里',
      dictFileTooBig: '图片上传失败, 尺寸需小于25M',
    });

    dropzone.on("success", function(file) {
      console.log(file.xhr.response);
      var self = this;
      setTimeout(function(){
        self.removeFile(file);
      }, 2000);
    });
  }
});
