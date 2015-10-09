# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




$(document).ready ->
  $(".conv-user").click ->
    $(this).parent().next('.conv-detail').toggle()
    return

  $(".conv-reply").click ->
    $('.reply-message').toggle()
    $('.message-to').val($(this).prev().text())
    return

  suggestions = new Bloodhound(
    datumTokenizer: (datum) ->
      Bloodhound.tokenizers.whitespace datum.value

    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: "/profile/email_list?query=%QUERY"
      filter: (response) ->
        $.map response.suggestions, (suggestion, index) ->
          value: suggestion.email
  )

  suggestions.initialize()

  $("#email-suggestion").typeahead null,
    displayKey: "value"
    source: suggestions.ttAdapter()

  return

