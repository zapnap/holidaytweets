$(document).ready(function() {
  $(this).everyTime(5000, 'updateTweet', updateTweet);

  function updateTweet() {
    last_status = null;
    params = '';

    if ($('#message').find('.status').length > 0) {
      if ($('#message').find('.status').attr('id') != '') {
        last_status = $('#message').find('.status').attr('id').split('-')[1];
        params = '?since_id=' + last_status;
      }
    }

    $.getJSON('http://' + document.location.host + '/recent.json' + params, function(data) {
      if (data.length > 0) {
        last_status  = data[0].twitter_id;
        last_message = $('<span/>').addClass('status').addClass('hidden').attr('id', 'status-' + last_status).text(data[0].text);
        last_byline  = $('<span/>').addClass('author').addClass('hidden').text(data[0].from_user_name);

        $('#message').append(last_message);
        $('#message').find('.status').not('.hidden').fadeOut(1000, function() {
          last_message.fadeIn(1000, function () {
            $(this).removeClass('hidden');
          });
          $(this).remove();
        });

        $('#byline').append(last_byline);
        $('#byline').find('.author').not('.hidden').fadeOut(1000, function() {
          last_byline.fadeIn(1000, function() {
            $(this).removeClass('hidden');
          });
          $(this).remove();
        });
      }
    });
  }
});
