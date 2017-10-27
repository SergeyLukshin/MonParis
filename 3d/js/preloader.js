function Preloader(selector, imagesArray, extComplete, extProgress, extError)  {

	if (selector !==  null) {
		var panel = document.createElement('div'); 	panel.className = "pro360-progress-panel";
		var panelText = document.createElement('div'); 	panelText.className = "pro360-progress-panel-text";
		var progress = document.createElement('div'); 	progress.className = "pro360-progress";
		var progress_bar = document.createElement('div'); 	progress_bar.className = "pro360-progress-bar";
		progress.appendChild(progress_bar);
		panel.appendChild(panelText);
		panel.appendChild(progress);
		document.querySelector(selector).appendChild(panel);
	}
	//var legend = document.createElement('span');
	//document.body.appendChild(legend);

	function onProgress(img, imageEl, index) {
		var percent = Math.floor((100 / this.queue.length) * this.completed.length);
		if (progress_bar) progress_bar.style.width = percent + "%";
		if (extProgress) extProgress(img, imageEl, index);
	};

	function onComplete(loaded, errors){
		// fires when whole list is done. cache is primed.
		if (panel) panel.style.display = "none";
		console.log('done');
		if (errors)
			console.log('the following failed', errors);
		if (extComplete) extComplete(loaded, errors);
	};

	function onError() {
		//alert("Ошибка загрузка изображений");
	};

	return new preLoader(imagesArray, {
		cacheBurst: false,
		onProgress: extProgress ? extProgress : onProgress,
		onComplete: onComplete,
		onError: extError ? extError : onError
	});
}