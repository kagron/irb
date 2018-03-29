$ ->
$('#user_search').typeahead
    name: "user"
    remote: "/users/autocomplete?query=%QUERY"
