$(document).on 'ready page:load', ->
  $("#jp_container_1 .jp-playlist").hide()
  cssSelector =
    jPlayer: "#jquery_jplayer_1"
    cssSelectorAncestor: "#jp_container_1"

  playlist = [] # Empty playlist
  options =
    swfPath: "js"
    supplied: "mp3"
    autoPlay: false

  myPlaylist = new jPlayerPlaylist(cssSelector, playlist, options)
  song_obj = $(".songs_list").data("songs-list")
  for url of song_obj
    myPlaylist.add
      title: song_obj[url]
      mp3: url

  $(".song-play").on "click", ->
    _this = $(this)
    if _this.hasClass("active-song")
      myPlaylist.pause()
      $(".audio-playlist").removeClass "active-song"
      $(".audio-playlist i").removeClass "fa-pause"
      $(".audio-playlist i").addClass "fa-play"
      $(".audio-playlist").find(".song-play").removeClass "active-song"
    else
      _this.addClass "active-song"
      myPlaylist.play $(this).data("song-number")
      $(".audio-playlist i").removeClass "fa-pause"
      $(".audio-playlist i").addClass "fa-play"
      _this.find("i").addClass "fa-pause"
    return

  $("#s_list").on "click", ->
    if $(this).hasClass("open")
      $(".jp-playlist").hide()
      $(this).removeClass "open"
    else
      $(this).addClass "open"
      $(".jp-playlist").show()
    return

  $(".my-song").on "click", ->
    song_url = $(this).data('song')
    $("#jquery_jplayer_1").jPlayer("setMedia", {mp3: song_url}).jPlayer("play");
    return

  return
