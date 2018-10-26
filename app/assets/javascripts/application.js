// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require jquery.dragtable
//= require_tree ./channels
//= require turbolinks
//= require sweetalert.js
//= require Chart.bundle
//= require chartkick
//= require_tree .


var ready;

ready = function() {
  	var url = window.location.pathname;
  	console.log(url)
  	if (url.includes('semester_competences')){
  		$("#nav-grid").addClass('active');
  	} else if(url.includes('usuario')){
  		$("#nav-users").addClass('active');
  	} else if(url.includes('semesters')){
  		$("#nav-semesters").addClass('active');
  	}
}

$(document).on('ready turbolinks:load', ready);
