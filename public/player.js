/*
 * Create an array of parameter objects from a given searchString.
 *
 */
function getParams(searchString){
  return searchString.replace('?', '').split('&').map(function(paramString) {
    var param = paramString.split('=');
    return { id: param[0], value: param[1] };
  });
}

/*
 * Find a specific parameter by id in an array of parameters and return its
 * value.
 *
 */
function getParam(needle, haystack) {
  var found = haystack.filter(function(h) {
    return h.id === needle;
  });
  if(found && found[0]) {
    return found[0].value;
  }
  return null;
}

/*
 * Perform an AJAX request to the server looking for media associated with :id.
 * If media is found, then call setupPlayer() to init the player.
 * Otherwise fail with a console.log message.
 *
 */
function getMediaBy(params) {
  var id = getParam('id', params);
  var request = new XMLHttpRequest();
  request.open('GET', '/v1/media_files/' + id, true);

  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      // Success!
      var data = JSON.parse(request.responseText);
      setupPlayer(data, params);
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
function setupPlayer(media, params) {
  var playerInstance = jwplayer("mediaPlayer");
  playerInstance.setup({
    autostart: getParam('autostart', params),
    playlist: [{
      image: media.thumbnailUrl,
      sources: [{
        file: media.contentUrl[1] // RTMP
      },{
        file: media.contentUrl[0] // Apple HLS
      }]
    }],
    primary: 'html5',
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
  var params = getParams(window.location.search);
  getMediaBy(params);
}
