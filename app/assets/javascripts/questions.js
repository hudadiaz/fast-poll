$(document).on('turbolinks:load', function() {
  $('#new_question').on('cocoon:before-remove', function(e) {
    var choices = $(this).find('.nested-fields')
    if (choices.length === 2) {
      e.preventDefault();
    }
  });
  $('#new_question').on('cocoon:after-insert', function(e, elm) {
    $(elm.find('input')[0]).focus()
  });
})
$(document).on('turbolinks:load', function() {
  $('.choice').on('click', function(e) {
    var input = $(this).find('input');
    if ($(input).attr('type') === 'checkbox') {
      $(input).prop('checked', !$(input).prop('checked'));
    } else {
      $(this).parent('.answers').find('input').prop('checked', false);
      $(input).prop('checked', true);
    }
    $(input).focus();
    e.preventDefault();
  })
})
