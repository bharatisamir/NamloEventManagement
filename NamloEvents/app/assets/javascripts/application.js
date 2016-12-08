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
//= require jquery
//= require bootstrap
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require best_in_place
//= require_tree .



$('a[data-popup]').live('click', function(e) {

    if($(this).attr('href').includes("event_details"))
    {
        window.open( $(this).attr('href'), "Popup", "toolbar=yes, scrollbars=yes,resizable=yes,top=500, left=400,height=600, width=800" );

    }

    else if($(this).attr('href').includes("invitation"))
    {
        window.open( $(this).attr('href'), "Popup", "toolbar=yes, scrollbars=yes,resizable=yes,top=500, left=400,height=1000, width=1400" );

    }
    else
    {
        window.open( $(this).attr('href'), "Popup", "toolbar=yes, scrollbars=yes,resizable=yes,top=500, left=500,height=600, width=500" );

    }
    e.preventDefault();

});
