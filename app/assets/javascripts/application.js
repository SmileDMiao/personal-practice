// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dist/app.js
//= require dist/jquery.soulmate
//= require rails.validations
//= require social-share-button
//= require jquery.atwho
//= require_tree .

window.App = {
    'locale': 'zh-CN',
    'current_user_id': null,
    'root_url': 'If deploy to production you can set this as your website address'
}
