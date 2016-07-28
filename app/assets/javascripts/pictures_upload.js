$(document).ready(function(){
  window.selected = 'black';
  $("#selectable").selectable({
    selected: function(event, ui) {
      if (ui.selected.classList.contains('white')) {
        window.selected = 'white'
      } else {
        window.selected = 'black'
      }
    }
  });

  // disable auto discover
  Dropzone.autoDiscover = false;

  var appendContent = function(picUrl, picId) {
    console.log(picId + "  " + picUrl);
    $("#pictures").prepend('<div class="col-lg-12">' +
      '<div class="thumbnail"><img src="' + picUrl + '"/>' +
      '<div class="caption">' +
      '<input id="pictures_" name="pictures[]" value="' + picId +'" type="checkbox">' +
      '</div>' +
      '</div></div>');
  };

  if ($('.dropzone').length) {
    var dropzone = new Dropzone (".dropzone", {
      maxFilesize: 25, // set the maximum file size to 25 MB
      acceptedFiles: ".jpeg,.jpg,.png",
      paramName: "picture[file_name]", // Rails expects the file upload to be something like model[field_name]
      addRemoveLinks: false, // don't show remove links on dropzone itself.
      // previewsContainer: ".dropzone-previews",
      dictDefaultMessage: '拖拽图片到这里',
      dictFileTooBig: '图片上传失败, 尺寸需小于25M',
    });

    dropzone.on('complete', function(files){
      var self = this;
      if (self.getUploadingFiles().length === 0 && self.getQueuedFiles().length === 0) {
        console.log('all completed');
        setTimeout(function(){
          var acceptedFiles = self.getAcceptedFiles();
          var rejectedFiles = self.getRejectedFiles();

          for(var index = 0; index < acceptedFiles.length; index++) {
            var file = acceptedFiles[index];
            var response = JSON.parse(file.xhr.response);
            appendContent(response.file_name.url, response.id);
          }

          if(acceptedFiles.length != 0) {
            alertify.success('成功上传了 ' + acceptedFiles.length + ' 张图片。');
          }
          if(rejectedFiles.length != 0) {
            alertify.error('有 ' + rejectedFiles.length + ' 张图片无法上传。请确认图片格式。');
          }

          self.removeAllFiles();
        }, 2000);
      }
    });
  }
});
