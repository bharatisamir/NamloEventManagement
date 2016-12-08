
$("#service").empty().append("<%= escape_javascript(render(:partial => @event_bookings)) %>")