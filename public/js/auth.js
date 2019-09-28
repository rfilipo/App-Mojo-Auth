/* auth system for App::Mojo */

/** 
 it looks for a cookie with an authorization key, 
 if found it opens the url sending the auth key
 otherwise, shows the login screen.
*/
console.log('Auth system for App::Mojo');

/* main init */
let urlLogin = "/";
let my_url  = window.location.href;
let my_path = window.location.pathname + window.location.search;

console.log("My url: "+my_url);
console.log("My path: "+my_path);

/* read cookie */
let key = getCookieValue('auth_key');

if (key) {
  /* it's auth, send key in header */
  if (my_path == '/') {
    my_path = "home";
  }
  let params = "auth=true";
  console.log("Have auth key");
  console.log("Opening /api/post/"+my_path);
  xhr = new XMLHttpRequest();
  xhr.open('POST', "/api/post/"+my_path, true);
  xhr.setRequestHeader('App-Mojo-Auth', key);
  xhr.send(params);
  xhr.addEventListener("load", loadPage);
} else {
  /* have to authenticate */
  let loginScreen = `
  <form>
  <h1>Login</h1>
  <ul>
  <li>username: <input name="username" id='username' autocomplete="username"></li>
  <li>password: <input name="password" id='password' type="password" autocomplete="current-password"></li>
  <li><input type="button" value="login" id='login'></li>
  </ul>
  </form>
  `;
  
  let page = document.getElementById('page');
  page.innerHTML = loginScreen;
  
  let login    = document.getElementById('login');
  let username = document.getElementById('username');
  let password = document.getElementById('password');
  let urlAuth = "/auth";
  
  login.onclick = () => {
    let params = "username="+username.value+"&"+"password="+password.value;
    console.log('login clicked');
    console.log(params);
    xhr = new XMLHttpRequest();
    xhr.open('POST', urlAuth, true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(params);
    xhr.addEventListener("load", getKey);
  };
}

function getCookieValue(a) {
    var c_value = document.cookie.match('(^|;)\\s*' + a + '\\s*=\\s*([^;]+)');
    return c_value ? c_value.pop() : '';
}

function getKey() {
  console.log(this.responseText);
  document.cookie = "auth_key=" + this.responseText;
}

function deleteKey(){
  console.log(this.responseText);
  document.cookie = "auth_key=expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
}

function loadPage() {
  console.log(this.responseText);
}


