$(document).on('turbolinks:load', function() {
  function buildChildForm() {
    var html = `<div class="wrapper__main__list__select__wrap child-form">
                  <select class="item-registration__form__group__box__select__body" id="child-form" name="item[category_id]">
                    <option value>---</option>
                  </select>
                  <i class="fas fa-chevron-down"></i>
                </div>`
    return html;
  }
  function buildChildOption(child) {
    var childOption = `<option value="${child.id}">${child.name}</option>`
    return childOption;
  }

  function buildGrandChildForm() {
    var html = `<div class="wrapper__main__list__select__wrap grandchild-form">
                  <select class="item-registration__form__group__box__select__body" id="grandchild-form" name="item[category_id]">
                    <option value>---</option>
                  </select>
                  <i class="fas fa-chevron-down"></i>
                </div>`
    return html;
  }
  function buildGrandChildOption(child) {
    var GrandChildOption = `<option value="${child.id}">${child.name}</option>`
    return GrandChildOption;
  }
  //子カテゴリーの作成
  $('#parent-category').on('change', function() {
    var parentValue = document.getElementById("parent-form").value;
    $('.child-form').remove();
    $('.grandchild-form').remove();
    $('.hidden').css({'display': 'none'});
    $('.edit-hidden').css({'display': 'none'});

    $.ajax({
      url: '/items/category_search',
      type: 'GET',
      data: {parent_id: parentValue},
      dataType: 'json'
    })
    .done(function(child) {
      var InsertHTML = '';
      $('#child-category').append(buildChildForm());
      child.forEach(function(child) {
        InsertHTML = buildChildOption(child);
        $('#child-form').append(InsertHTML);
      })
    })
    .fail(function() {
      alert('error');
    })
  });
  //孫カテゴリーの作成
  $('#child-category').on('change', '#child-form', function() {
    var childValue = document.getElementById("child-form").value;
    $('.grandchild-form').remove();
    $('.hidden').css({'display': 'none'});

    $.ajax({
      url: '/items/category_search',
      type: 'GET',
      data: {parent_id: childValue},
      dataType: 'json'
    })
    .done(function(child) {
      var InsertHTML = '';
      $('#grandchild-category').append(buildGrandChildForm());
      child.forEach(function(child) {
        InsertHTML = buildGrandChildOption(child);
        $('#grandchild-form').append(InsertHTML);
      })
    })
    .fail(function() {
      alert('error');
    })
  });
  //サイズフォームの表示
  $('#grandchild-category').on('change', '#grandchild-form', function() {
    $('.hidden').css({'display': 'block'});
  });
  $('#grandchild-category').on('change', '#grandchild-form', function() {
    $('.edit-hidden').css({'display': 'block'});
  });
});
