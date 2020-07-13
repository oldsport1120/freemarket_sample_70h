$(document).on('turbolinks:load', function() { 
  
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='detail-block-category__form'>
                        <select class="detail-block-category__form--select input-area" id="child_category" name="product[category_id]">
                          <option value="---" data-category="---">---</option>
                          ${insertHTML}
                        <select>
                      </div>`;
    $('.detail-block__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='detail-block-category__form'>
                                <select class="detail-block-category__form--select input-area" id="grandchild_category" name="product[category_id]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                            </div>`;
    $('.detail-block__category').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#product_category_id').change(function(e){
    e.preventDefault();
    console.log("OK")
    var parentCategory = document.getElementById('product_category_id').value; //選択された親カテゴリーの名前を取得
    console.log(parentCategory)
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/categorys/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        console.log(children)
        $('#child_category').remove(); //親が変更された時、子以下を削除するする
        $('#grandchild_category').remove();
        var insertHTML = '';
        children.forEach(function(child){
          console.log(child);
          insertHTML += appendOption(child);
        });
        console.log(insertHTML);
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
      $('#grandchild_category').remove();

    }
  });
  // 子カテゴリー選択後のイベント
  $('.detail-block__category').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: ' /categorys/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category').remove(); //子が変更された時、孫以下を削除するする
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });
});