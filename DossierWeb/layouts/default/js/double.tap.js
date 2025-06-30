/*!
 * jQuery Double Tap Plugin.
 *
 * Copyright (c) 2010 Raul Sanchez (http://www.appcropolis.com)
 *
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 */

(function($){
    // Determine if we on iPhone or iPad
    var isiOS = false;
    var agent = navigator.userAgent.toLowerCase();
    if(agent.indexOf('iphone') != 0 || agent.indexOf('ipad') != 0){
           isiOS = true;
    }

    $.fn.doubletap = function(onDoubleTapCallback, onTapCallback, delay){
        var eventName, action;
        delay = delay == null? 500 : delay;
        eventName = isiOS == true? 'touchend' : 'click';

        $(this).bind(eventName, function(event){
            var now = new Date().getTime();
            var lastTouch = $(this).data('lastTouch') || now + 1 /** the first time this will make delta a negative number */;
            var delta = now - lastTouch;
            clearTimeout(action);
            if(delta<500 && delta>0){
                if(onDoubleTapCallback != null && typeof onDoubleTapCallback == 'function'){
                    onDoubleTapCallback(event,$(this));
                }
            }else{
                $(this).data('lastTouch', now);
                action = setTimeout(function(evt){
                    if(onTapCallback != null && typeof onTapCallback == 'function'){
                        onTapCallback(evt,$(this));
                    }
                    clearTimeout(action);   // clear the timeout
                }, delay, [event]);
            }
            $(this).data('lastTouch', now);
        });
    };




})(jQuery);


// @author Rich Adams <rich@richadams.me>

// Implements a tap and hold functionality. If you click/tap and release, it will trigger a normal
// click event. But if you click/tap and hold for 1s (default), it will trigger a taphold event instead.



;(function($)
{
    // Default options
    var defaults = {
        duration: 1000, // ms
        clickHandler: null
    }

    // When start of a taphold event is triggered.
    function startHandler(event)
    {
        var $elem = jQuery(this);

        // Merge the defaults and any user defined settings.
        settings = jQuery.extend({}, defaults, event.data);

        // If object also has click handler, store it and unbind. Taphold will trigger the
        // click itself, rather than normal propagation.
        if (typeof $elem.data("events") != "undefined"
            && typeof $elem.data("events").click != "undefined")
        {
            // Find the one without a namespace defined.
            for (var c in $elem.data("events").click)
            {
                if ($elem.data("events").click[c].namespace == "")
                {
                    var handler = $elem.data("events").click[c].handler
                    $elem.data("taphold_click_handler", handler);
                    $elem.unbind("click", handler);
                    break;
                }
            }
        }
        // Otherwise, if a custom click handler was explicitly defined, then store it instead.
        else if (typeof settings.clickHandler == "function")
        {
            $elem.data("taphold_click_handler", settings.clickHandler);
        }

        // Reset the flags
        $elem.data("taphold_triggered", false); // If a hold was triggered
        $elem.data("taphold_clicked",   false); // If a click was triggered
        $elem.data("taphold_cancelled", false); // If event has been cancelled.

        // Set the timer for the hold event.
        $elem.data("taphold_timer",
            setTimeout(function()
            {
                // If event hasn't been cancelled/clicked already, then go ahead and trigger the hold.
                if (!$elem.data("taphold_cancelled")
                    && !$elem.data("taphold_clicked"))
                {
                    // Trigger the hold event, and set the flag to say it's been triggered.
                    $elem.trigger(jQuery.extend(event, jQuery.Event("taphold")));
                    $elem.data("taphold_triggered", true);
                }
            }, settings.duration));
    }

    // When user ends a tap or click, decide what we should do.
    function stopHandler(event)
    {
        var $elem = jQuery(this);

        // If taphold has been cancelled, then we're done.
        if ($elem.data("taphold_cancelled")) { return; }

        // Clear the hold timer. If it hasn't already triggered, then it's too late anyway.
        clearTimeout($elem.data("taphold_timer"));

        // If hold wasn't triggered and not already clicked, then was a click event.
        if (!$elem.data("taphold_triggered")
            && !$elem.data("taphold_clicked"))
        {
            // If click handler, trigger it.
            if (typeof $elem.data("taphold_click_handler") == "function")
            {
                $elem.data("taphold_click_handler")(jQuery.extend(event, jQuery.Event("click")));
            }

            // Set flag to say we've triggered the click event.
            $elem.data("taphold_clicked", true);
        }
    }

    // If a user prematurely leaves the boundary of the object we're working on.
    function leaveHandler(event)
    {
        // Cancel the event.
        $(this).data("taphold_cancelled", true);
    }

    // Determine if touch events are supported.
    var touchSupported = ("ontouchstart" in window) // Most browsers
                         || ("onmsgesturechange" in window); // Microsoft

    var taphold = $.event.special.taphold =
    {
        setup: function(data)
        {
            $(this).bind((touchSupported ? "touchstart" : "mousedown"),  data, startHandler)
                   .bind((touchSupported ? "touchend"   : "mouseup"),    stopHandler)
                   .bind((touchSupported ? "touchmove"  : "mouseleave"), leaveHandler);
        },
        teardown: function(namespaces)
        {
            $(this).unbind((touchSupported ? "touchstart" : "mousedown"),  startHandler)
                   .unbind((touchSupported ? "touchend"   : "mouseup"),    stopHandler)
                   .unbind((touchSupported ? "touchmove"  : "mouseleave"), leaveHandler);
        }
    };
})(jQuery);

$(function(){

    var isiOS = false;
    var agent = navigator.userAgent.toLowerCase();
    if(agent.indexOf('iphone') != 0 || agent.indexOf('ipad') != 0){
           isiOS = true;
    }

	$('.table-mere tr').doubletap(
		//_that = $(this)
        /** doubletap-dblclick callback */
        function(event,obj){
            var target = $(event.target);
			var tr = target.parents('tr');
			var waction = tr.parents('.table').attr('data-waction');
			var page = get('page');
			if(page!=='') {
				var page = '&page='+page;
			}else{
				var page = '&page=1';
			}
			
			var order = get('order');
			if(order!=='') {
				var order = '&order='+order;
			}else{
				var order = '';
			}
			
			var direction = get('direction');
			if(direction!=='') {
				var direction = '&direction='+direction;
			}else{
				var page = '';
			}
			
			var id = tr.find('td:eq(0)').text();
			
            window.location.href = '/'+waction+'?action=edit&uid='+id+page+order+direction
        },
        /** touch-click callback (touch) */
        function(event){
            //alert('single-tap');
        },
        /** doubletap-dblclick delay (default is 500 ms) */
        400
	);
	
	$('.table-ligne tr').doubletap(
		//_that = $(this)
        /** doubletap-dblclick callback */
        function(event,obj){
			alert('ok');
            
			
        },
        /** touch-click callback (touch) */
        function(event){
            //alert('single-tap');
        },
        /** doubletap-dblclick delay (default is 500 ms) */
        400
	);


    /*if(isiOS){

        $('.table-mere tr').on("taphold", function(){

            $(this).trigger({
                type: 'mousedown',
                which: 3
            });

        });

    }*/

	

})
