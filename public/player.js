/*
 * Perform an AJAX request to the server looking for media associated with :id.
 * If media is found, then call setupPlayer() to init the player.
 * Otherwise fail with a console.log message.
 *
 */
function getMediaByUID(id) {

  var request = new XMLHttpRequest();
  request.open('GET', '/v1/media_files/' + id, true);

  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      // Success!
      var data = JSON.parse(request.responseText);
      setupPlayer(data);
    } else {
      // We reached our target server, but it returned an error
      console.log("No media available with uid " + id + ".");
    }
  };

  request.onerror = function() {
    // There was a connection error of some sort
    console.log("There was a connection error of some sort");
  };

  request.send();

  return;
}

/*
 * Setup a jwPlayer media player using the specified :media.
 *
 */
function setupPlayer(media) {
  console.log(media)
  var playerInstance = jwplayer("mediaPlayer");
  playerInstance.setup({
    playlist: [{
      image: media.thumbnailUrl,
      title: media.name,
      sources: [{
        file: media.contentUrl[1] // RTMP
      },{
        file: media.contentUrl[0] // Apple HLS
      }]
    }],
  });
}

/*
 * Start execution of code.
 *
 * Check if current URL has a valid ID in it and request it from the API if it
 * does.
 *
 */
if(!window.location.search) {
  console.log("No media was specifed in the URL");

} else if(window.location.search) {
  var uid = window.location.search.replace("?id=", "");
  console.log(uid);
  getMediaByUID(uid);
}
