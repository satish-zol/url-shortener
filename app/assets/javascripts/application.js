// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require_tree .


$.validator.addMethod("regex", function(value, element, regexp){
    var regEx = new RegExp(regexp);
    return this.optional(element) || regEx.test(value);
}, "Please enter a valid URL(using http)");

$("#new_link").ready(function(){
    var url_validator = $("#new_link").validate({
        rules: {
            'link[give_url]': {
                required: true,
                regex: "^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}"
            },
        },
        messages: {
            'link[given_url]':{
                required: 'Please put in a URL',
            }
        }
    });
});