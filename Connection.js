.pragma library

//var rootUrl = 'http://api.dev';
var rootUrl = 'https://yhteys.kotivo.fi';
var apiUrl = rootUrl + '/api/v1';
var systemUrl = rootUrl + '';

function request(method, url, headers, body, raw, cb_ok, cb_error) {
	var http = new XMLHttpRequest();
	http.open(method, url);
	for (var key in headers) {
		console.log('header: ' + key + ': ' + headers[key]);
		http.setRequestHeader(key, headers[key]);
	}
	http.setRequestHeader('Content-Type', 'application/json');
	http.onreadystatechange = function() { // Call a function when the state changes.
		if (http.readyState == 4) {
			if (http.status == 200) {
				try {
					var response = http.responseText;
					if (raw !== true) {
						response = JSON.parse(response).data;
					}
					if (cb_ok !== undefined) {
						cb_ok(response);
					}
				} catch(e) {
					console.log('error (' + http.status + '): ' + http.responseText.slice(0, 100));
					if (cb_error !== undefined) {
						cb_error(http);
					}
				}
			} else if (http.status < 200 || http.status == 403 || http.status == 500) {
				/* connection to server failed somehow or access denied, show login */
				console.log('error (' + http.status + ')');
				if (cb_error !== undefined) {
					cb_error(http);
				}
			} else {
				/* some other error occured, just show error */
				console.log('error (' + http.status + ')');
				if (cb_error !== undefined) {
					cb_error(http);
				}
			}
		}
	}
	console.log(method + ' ' + url);
	http.send(body);
}

function get(postfix, cb_ok, cb_error) {
	postfix += postfix.slice(-1) !== '/' ? '/' : '';
	request('GET', apiUrl + postfix, {}, undefined, false, cb_ok, cb_error);
}

function put(postfix, data, cb_ok, cb_error) {
	postfix += postfix.slice(-1) !== '/' ? '/' : '';
	request('PUT', apiUrl + postfix, {}, JSON.stringify(data), false, cb_ok, cb_error);
}

function login(username, password, admin_username, admin_password, cb_ok, cb_error) {
	if (admin_username && admin_password) {
		request('GET', systemUrl + '/account/fake/' + username + '/', { 'Authorization': 'Basic ' + Qt.btoa(admin_username + ':' + admin_password) }, undefined, true, cb_ok, cb_error);
	} else {
		put('/accounts/login/', { 'username': username, 'password': password }, cb_ok, cb_error);
	}
}

function logout(callback) {
	get('/accounts/logout/', callback);
}

function controllersGet(model, cb_error) {
	get('/controllers/', function(controllers) {
		for (var j = 0; j < model.count; j++) {
			var found = false;
			for (var i = 0; i < controllers.length; i++) {
				if (model.get(j).id === controllers[i].id) {
					found = true;
					break;
				}
			}
			if (!found) {
				model.remove(j);
			}
		}
		for (var i = 0; i < controllers.length; i++) {
			var found = false;
			for (var j = 0; j < model.count; j++) {
				if (model.get(j).id === controllers[i].id) {
					found = true;
					break;
				}
			}
			if (!found) {
				model.append(controllers[i]);
			} else {
				model.set(j, controllers[i]);
			}
		}
	}, cb_error);
}

function controllerAway(controller, away, cb_ok, cb_error) {
	put('/controllers/' + controller.id + '/profiles/away/', { 'away': away }, cb_ok, cb_error);
}

function modulesGet(controller, model) {
	get('/controllers/' + controller.id + '/modules/', function(modules) {
		for (var j = 0; j < model.count; j++) {
			var found = false;
			for (var i = 0; i < modules.length; i++) {
				if (model.get(j).id === modules[i].id) {
					found = true;
					break;
				}
			}
			if (!found) {
				model.remove(j);
			}
		}
		for (var i = 0; i < modules.length; i++) {
			var found = false;
			for (var j = 0; j < model.count; j++) {
				if (model.get(j).id === modules[i].id) {
					found = true;
					break;
				}
			}
			if (!found) {
				model.append(modules[i]);
			} else {
				model.set(j, modules[i]);
			}
		}
	});
}

function moduleAway(controller, module, away, cb_ok, cb_error) {
	put('/controllers/' + controller.id + '/modules/' + module.id, { 'away': away }, cb_ok, cb_error);
}

