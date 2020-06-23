// // turbolinksを先に読み込む
// $(document).on('turbolinks:load', function() {

//   // 画像を管理するための配列を定義する。
//   var pictures = [];

//   // htmlを定義
//   function buildHTML(imgSrc){
//     var html =  `<div class="preview-box">
//                   <div class="preview-box__img-box">
//                     <img src="${imgSrc}", class="image">
//                   </div>
//                   <div class="preview-box__select">
//                     <div class="preview-box__select--delete">
//                       <p>削除</p>
//                     </div>
//                   </div>
//                 </div>`
//     // .dropzoneの配列の最初に追加
//     $('.dropzone').prepend(html);
//   };


//   // 画像を入れた時にイベント発火
//   $('#upload-image').on("change", function(e){
//     // イベント発火したファイルを定義
//     var files = e.target.files;
//     // 画像のファイルを一つづつ、先ほどの画像管理用の配列に追加する。
//     for (var i = 0, f; f = files[i]; i++){
//       // FileReaderを新しく作成し、定義したreaderに返す
//       let reader = new FileReader();
//       reader.readAsDataURL(f);
//       reader.onload = function(){
//         let imgSrc = reader.result;
//         // htmlの呼び出し
//         buildHTML(imgSrc);
//         pictures.push(imgSrc);
//       }
//     }
//   });
  
//   // $('#new_product').on('submit', function(e){
//   //   e.preventDefault();
//   //   // そのほかのform情報を以下の記述でformDataに追加
//   //   var formData = new FormData($(this).get(0));
//   //   // ドラッグアンドドロップで、取得したファイルをformDataに入れる。
//   //   pictures.forEach(function(file){
//   //    formData.append("picture[pictures][]" , file)
//   //   });
//   //   $.ajax({
//   //     url:         '/products/new',
//   //     type:        "POST",
//   //     data:        formData,
//   //     contentType: false,
//   //     processData: false,
//   //     dataType:   'json',
//   //   })
//   //   .done(function(data){
//   //     alert('出品に成功しました！');
//   //   })
//   //   .fail(function(XMLHttpRequest, textStatus, errorThrown){
//   //     alert('出品に失敗しました！');
//   //   });
//   // });

//   // 削除ボタンを押すとイベント発火
//   $(document).on('click', '.preview-box__select p', function(){
//     $(this).closest('.preview-box').remove();
//   });

//   // 削除ボタンを押すとイベント発火(既存画像用)
//   $(document).on('click', '.preview-box__select p', function(){
//     if ($('.preview-box__select p').length == 1) {
//       alert('削除できません');
//       //要素の効果を無効化する
//       return false;
//     } else {
//     $(this).closest('.image-box').remove();
//     }
//   });
// });

// $(document).on('turbolinks:load', function(){
//   var dropzone = $('.dropzone-area');
//   var dropzone2 = $('.dropzone-area2');
//   var dropzone_box = $('.dropzone-box');
//   var images = [];
//   var inputs  =[];
//   var input_area = $('.input_area');
//   var preview = $('#preview');
//   var preview2 = $('#preview2');

//   $(document).on('change', 'input[type= "file"].upload-image',function(event) {
//     var file = $(this).prop('files')[0];
//     var reader = new FileReader();
//     inputs.push($(this));
//     var img = $(`<div class= "img_view"><img></div>`);
//     reader.onload = function(e) {
//       var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
//       img.append(btn_wrapper);
//       img.find('img').attr({
//         src: e.target.result
//       })
//     }
//     reader.readAsDataURL(file);
//     images.push(img);

//     if(images.length >= 5) {
//       dropzone2.css({
//         'display': 'block'
//       })
//       dropzone.css({
//         'display': 'none'
//       })
//       $.each(images, function(index, image) {
//         image.attr('data-image', index);
//         preview2.append(image);
//         dropzone2.css({
//           'width': `calc(100% - (135px * ${images.length - 5}))`
//         })
//       })
//       if(images.length == 9) {
//         dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
//       }
//     } else {
//         $('#preview').empty();
//         $.each(images, function(index, image) {
//           image.attr('data-image', index);
//           preview.append(image);
//         })
//         dropzone.css({
//           'width': `calc(100% - (135px * ${images.length}))`
//         })
//       }
//       if(images.length == 4) {
//         dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
//       }
//     if(images.length == 10) {
//       dropzone2.css({
//         'display': 'none'
//       })
//       return;
//     }
//     var new_image = $(`<input multiple= "multiple" name="pictures[picture][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
//     input_area.prepend(new_image);
//   });
//   $(document).on('click', '.delete', function() {
//     var target_image = $(this).parent().parent();
//     $.each(inputs, function(index, input){
//       if ($(this).data('image') == target_image.data('image')){
//         $(this).remove();
//         target_image.remove();
//         var num = $(this).data('image');
//         images.splice(num, 1);
//         inputs.splice(num, 1);
//         if(inputs.length == 0) {
//           $('input[type= "file"].upload-image').attr({
//             'data-image': 0
//           })
//         }
//       }
//     })
//     $('input[type= "file"].upload-image:first').attr({
//       'data-image': inputs.length
//     })
//     $.each(inputs, function(index, input) {
//       var input = $(this)
//       input.attr({
//         'data-image': index
//       })
//       $('input[type= "file"].upload-image:first').after(input)
//     })
//     if (images.length >= 5) {
//       dropzone2.css({
//         'display': 'block'
//       })
//       $.each(images, function(index, image) {
//         image.attr('data-image', index);
//         preview2.append(image);
//       })
//       dropzone2.css({
//         'width': `calc(100% - (135px * ${images.length - 5}))`
//       })
//       if(images.length == 9) {
//         dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
//       }
//       if(images.length == 8) {
//         dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
//       }
//     } else {
//       dropzone.css({
//         'display': 'block'
//       })
//       $.each(images, function(index, image) {
//         image.attr('data-image', index);
//         preview.append(image);
//       })
//       dropzone.css({
//         'width': `calc(100% - (135px * ${images.length}))`
//       })
//     }
//     if(images.length == 4) {
//       dropzone2.css({
//         'display': 'none'
//       })
//     }
//     if(images.length == 3) {
//       dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
//     }
//   })
// });

$(document).on('turbolinks:load', function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var dropzone_box = $('.dropzone-box');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }
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

      // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
    } else if (images.length == 5) {
      $("#preview").empty();
      $.each(images, function(index, image) {
        image.data("image", index);
        preview.append(image);
      });
      dropzone2.css({
        display: "block"
      });
      dropzone.css({
        display: "none"
      });
      preview2.empty();

      // 画像が６枚以上のとき
    } else if (images.length >= 6) {
      // １〜５枚目の画像を抽出
      var pickup_images1 = images.slice(0, 5);

      // １〜５枚目を１段目に表示
      $('#preview').empty();
      $.each(pickup_images1, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })

      // ６枚目以降の画像を抽出
      var pickup_images2 = images.slice(5);

      // ６枚目以降を２段目に表示
      $.each(pickup_images2, function(index, image) {
        image.data('image', index + 5);
        preview2.append(image);
      })

      dropzone.css({
        'display': 'none'
      })
      dropzone2.css({
        'display': 'block',
        'width': `calc(100% - (20% * ${images.length - 5}))`
      })

      // 画像が１０枚になったら枠を消す
      if (images.length == 10) {
        dropzone2.css({
          display: "none"
        });
      }
    }
    var new_image = $(`<input multiple= "multiple" name="product_pictures[picture][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });
  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (135px * ${images.length - 5}))`
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (135px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 3) {
      dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
    }
  })
});