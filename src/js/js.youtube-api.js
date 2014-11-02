/* Vars */

var first_vid = 'NI1LQ-yMkyU';

/* yt api start */

function updateHTML(elmId, value) {
	$('#' + elmId).append(value);
}

function hideIt(elmId) {
	$('#' + elmId).hide();
}

function showIt(elmId) {
	$('#' + elmId).show();
}

function updateBAR(elmId, value) {
	$('#' + elmId).width('100%');
}

function jHideIt(elmId) {
	$('#' + elmId).hide();
}

function jShowIt(elmId) {
	$('#' + elmId).show();
}

function jTranspIt(elmId) {
	$('#' + elmId).css('opaticy','0.0');
}

function jDeTranspIt(elmId) {
	$('#' + elmId).css('opaticy','1.0');
}

function jUpdatePos(elmId, value) {
	$('#' + elmId).css('left', value + '%');
}

function refreshSlider () {
	var value = $( "#slider" ).slider( "value" );
	var possec = (parseInt(ytplayer.getDuration()) * value)/100;
	seekVid(possec);
}

/* API Functions */

function onYouTubePlayerReady(playerId) {
	ytplayer = document.getElementById('ytPlayerID');
	// This causes the updatePlayerInfo function to be called every 333 ms to get fresh data from the player
	setInterval(updatePlayerInfo, 333);
	updatePlayerInfo();
	ytplayer.addEventListener('onStateChange', 'onPlayerStateChange');
	ytplayer.addEventListener('onError', 'onPlayerError');
	//Load an initial video into the player
	$('#ui_vol_on').hide();
	ytplayer.cueVideoById(first_vid);
}

function onPlayerError(errorCode) {
	alert('Ocurrió un error:' + errorCode);
}

function onPlayerStateChange(newState) {
	switch(newState) {
		case 0://Finish
			$('#ui_play').hide();
			$('#ui_pause').show();
			$('#jlog_res').removeClass('ajax-loading');
		break;
		case 1://Play
			$('#ui_play').hide();
			$('#ui_pause').show();
			$('#jlog_res').removeClass('ajax-loading');
		break;
		case 2://Pause
			$('#ui_play').show();
			$('#ui_pause').hide();
			$('#jlog_res').removeClass('ajax-loading');
		break;
		case 3://Loading
			$('#videoDuration').html('...buffer');
			$('#videoCurrentTimeText').html('&nbsp;');
			$('#ui_play').hide();
			$('#ui_pause').show();
			$('#jlog_res').empty().addClass('ajax-loading');
		break;
		case 5://En cola
			$('#videoDuration').html('...ready!');
			$('#videoCurrentTimeText').html('&nbsp;');
			$('#ui_play').hide();
			$('#ui_pause').show();
		break;
		default://Ready
			$('#ui_play').show();
			$('#ui_pause').hide();
	}
}

/* Control */

function updatePlayerInfo() {
	// Also check that at least one function exists since when IE unloads the
	// page, it will destroy the SWF before clearing the interval.
	if(ytplayer && ytplayer.getDuration) {
		var perc= (ytplayer.getCurrentTime()/ytplayer.getDuration())*100;
		$('.ui-slider-handle').css('left', perc+'%');
		
		var mDuration = parseInt(ytplayer.getDuration());
		var mCurrent = parseInt(ytplayer.getCurrentTime());
		var isMuted = ytplayer.isMuted();
		var minDurationVar = Math.floor(mDuration/60);  // The minutes
		var	secDurationVar = mDuration % 60;

		if (mCurrent > 0) {
			if (minDurationVar > 0) {
				$('#videoDuration').html(minDurationVar + 'm ' + secDurationVar + 's');
			} else {
				$('#videoDuration').html(secDurationVar + 's');
			}
			var minCurrentVar = Math.floor(mCurrent/60);  // The minutes
			var	secCurrentVar = mCurrent % 60; 
			if (minCurrentVar > 0) {
				$('#videoCurrentTimeText').html(minCurrentVar + 'm ' + secCurrentVar + 's');
			} else {
				$('#videoCurrentTimeText').html(secCurrentVar + 's');
			}
		}
	}
}

function setVideoVolume() {
	var volume = parseInt(document.getElementById('volumeSetting').value);
	if (isNaN(volume) || volume < 0 || volume > 100) {
		alert('Please enter a valid volume between 0 and 100.');
	} else if(ytplayer){
		ytplayer.setVolume(volume);
	}
}

function seekVid(posec) {
	if (ytplayer) {
		ytplayer.seekTo(posec, true);
	}
}

function loadVid(videoID) {
	if (ytplayer) {
		ytplayer.loadVideoById(videoID);
	}
}

function playVid() {
	if (ytplayer) {
		ytplayer.playVideo();
	}
}

function pauseVid() {
	if (ytplayer) {
		ytplayer.pauseVideo();
	}
}

function muteVid() {
	$('#ui_vol_on').show();
	$('#ui_vol_off').hide();
	if(ytplayer) {
		ytplayer.mute();
	}
}

function unMuteVid() {
	$('#ui_vol_off').show();
	$('#ui_vol_on').hide();
	if(ytplayer) {
		ytplayer.unMute();
	}
}

// The 'main method' of this sample. Called when someone clicks 'Run'.
function loadPlayer() {
	var params = {
		wmode: 'transparent',
		allowScriptAccess: 'always',
		allowFullScreen: 'true',
		bgcolor: '#000000'
	};
	var atts = { id: 'ytPlayerID' };
	swfobject.embedSWF('http://www.youtube.com/apiplayer?' +
		'&enablejsapi=1&playerapiid=ytplayer&version=3',
		'ytapiplayer', '700', '386', '10', null, null, params, atts);

}

/* yt api end */
