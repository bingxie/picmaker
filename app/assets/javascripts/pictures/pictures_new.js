$(document).on('turbolinks:load', function(){
  if ($('#new_picture').length) {
    var uploading = new Dropzone("#new_picture", {
      // url: "/pictures",
      paramName: 'picture[file_name]',
      acceptedFiles: ".jpeg,.jpg",
      maxFilesize: 25,
      addRemoveLinks: false,
      dictDefaultMessage: "点击或拖拽上传<br/>(带有EXIF信息的JPG格式)",
      dictFileTooBig: '图片上传失败, 尺寸需小于25M',
      maxFiles: 1,
      thumbnailWidth: 450,
      thumbnailHeight: 300,
    });

    uploading.on("maxfilesexceeded", function(file) {
      this.removeFile(file);
      alert("No more files please!");
    });

    uploading.on('success', function(file, data) {
      file.id = data.id;
      // setTimeout(function(){
      //   window.location.href = "/pictures/" + data.encoded_id + "/edit";
      // }, 2000);
      // Use server generated thumbnail
      // file.previewElement.setAttribute('data-id', data.id);
      // this.emit("thumbnail", file, data.file_name.thumb.url);
    });
  }
});
