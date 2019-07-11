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
  $('#parent-category').on('change', function() {
    var parentValue = document.getElementById("parent-form").value;
    $('.child-form').remove();

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
        InsertHTML += buildChildOption(child);
        $('#child-form').append(InsertHTML);
      })
    })
    .fail(function() {
      alert('error');
    })
  });
});
