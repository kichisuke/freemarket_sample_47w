$(document).on("turbolinks:load", function() {
  var dropzone = $(".item__image__upload__input-container");
  var dropzone2 = $(".item__image__upload2__input-container2");
  var appendzone = $(".item__image__upload2")
  var input_area = $(".input-area");
  var preview = $("#preview");
  var preview2 = $("#preview2");

  var images = [];
  var new_image_files = [];

  $(".item__image__upload, .item__image__upload2").on("change", 'input[type= "file"].upload-image', function() {

    var file = $(this).prop("files")[0];
    new_image_files.push(file)
    var reader = new FileReader();

    var img = $(`<div class= "add_img"><div class="img_area"><img class="image"></div></div>`);
    var btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');

    img.append(btn_wrapper);

    reader.onload = function(e) {
      img.find("img").attr({
        src: e.target.result
      });
    };

    reader.readAsDataURL(file);
    images.push(img);

    if (images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${images.length}))`
      })

    } else if (images.length == 5) {
      $("#preview").empty();
      $.each(images, function(index, image) {
        image.data("image", index);
        preview.append(image);
      });
      appendzone.css({
        display: "flex"
      });
      dropzone.css({
        display: "none"
      });
      preview2.empty();

    } else if (images.length >= 6) {
      var pickup_images = images.slice(5);

      $.each(pickup_images, function(index, image) {
        image.data("image", index + 5);
        preview2.append(image);
        dropzone2.css({
          width: `calc(100% - (20% * ${images.length - 5}))`
        });
      });

      if (images.length == 10) {
        dropzone2.css({
          display: "none"
        });
      }
    }

    var new_image = $(
      `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`
    );
    input_area.append(new_image);
  });

  $(".item__image__upload, .item__image__upload2").on('click', '.btn_delete', function() {
    var target_image = $(this).parent().parent();
    var target_image_num = target_image.data('image');

    target_image.remove();

    images.splice(target_image_num, 1);
    new_image_files.splice(target_image_num, 1);

    if(images.length == 0) {
      $('input[type= "file"].upload-image').attr({
        'data-image': 0
      })
    }

    if (images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${images.length}))`,
        'display': 'block'
      })
      appendzone.css({
        'display': 'none'
      })

    } else if (images.length == 5) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      appendzone.css({
        'display': 'block',
      })
      dropzone2.css({
        'width': '100%'
      })
      dropzone.css({
        'display': 'none'
      })
      preview2.empty();

    } else {
      var pickup_images1 = images.slice(0, 5);

      $('#preview').empty();
      $.each(pickup_images1, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })

      var pickup_images2 = images.slice(5);

      $.each(pickup_images2, function(index, image) {
          image.data('image', index + 5);
          preview2.append(image);
          dropzone2.css({
            'display': 'block',
            'width': `calc(100% - (20% * ${images.length - 5}))`
          })
        })
    }
  })


  $('.new_item').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData($(this).get(0));

    if (new_image_files.length == 0) {
      formData.append("new_images[images][]", " ")
    } else {
      new_image_files.forEach(function(file){
        formData.append("new_images[images][]", file)
      });
    }

    $.ajax({
      url:         '/items',
      type:        "POST",
      data:        formData,
      contentType: false,
      processData: false,
    })
  });
});