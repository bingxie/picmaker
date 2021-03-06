Dropzone.autoDiscover = false; // Disabling autoDiscover, otherwise Dropzone will try to attach twice.

$(document).on('turbolinks:load', function(){
  $("#selectable").selectable({
    selected: function(event, ui) {
      if (ui.selected.classList.contains('white')) {
        $('#picture_border_style').val('white')
      } else {
        $('#picture_border_style').val('black')
      }
    }
  });

  // disable auto discover
  var appendContent = function(picUrl, picId) {
    $("#pictures").prepend('<div class="col-lg-12">' +
      '<div class="thumbnail"><img src="' + picUrl + '"/>' +
      '</div></div>');
  };

  if ($('#border').length) {
    var dropzone = new Dropzone ("#border", {
      maxFilesize: 25, // set the maximum file size to 25 MB
      acceptedFiles: ".jpeg,.jpg,.png",
      paramName: "picture[file_name]", // Rails expects the file upload to be something like model[field_name]
      addRemoveLinks: false, // don't show remove links on dropzone itself.
      dictDefaultMessage: "拖拽照片到这里 或者 点击后选择照片(带有EXIF信息的JPG格式)",
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
            appendContent(response.file_name.border.url, response.encoded_id);
          }

          if(acceptedFiles.length != 0) {
            alertify.success('成功上传并处理了 ' + acceptedFiles.length + ' 张图片。');
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
