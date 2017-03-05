$('.modal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});


$('#court_picture').on('change', function(){
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5){
    alert('Maximum file size is 5MB. Please resize that file or choose another.');
  }
});


$(function() {
    $('.thumbnail').matchHeight();
});

$("#addCommentButton").on('click', function(event){
  event.preventDefault();
  $(".addComment").show();
})

$("#submitFormButton").on('click', function(event){
  event.preventDefault();
  var prefixHttp = "https://maps.googleapis.com/maps/api/geocode/json?address="
  var key = "&key=AIzaSyCHvA_HeK-Kj5bULpf9VkGl5SFGgyp3Fu8"
  var location = $("#court_location").val()
  var together = prefixHttp + location + key
  $.ajax({
    method: "GET",
    url: together,
    dataType: "json",
    success: function(data){
      if(data["status"] == "OK"){
        $("#court_latitude").val(data["results"][0]["geometry"]["location"]["lat"]);
        $("#court_longitude").val(data["results"][0]["geometry"]["location"]["lng"]);
        $("#submitForm").submit();
      } else {
        $("#flash-messages").text("Address not found. Please provide correct location.").addClass("alert alert-danger");
      }
    },
    error: function (request, status, error){
      $("#flash-messages").text("Location can't be blank. Please provide correct address.").addClass("alert alert-danger");
    }
  })
})


$(".close").on('click', function(){
  $(".addComment").hide();
})

$(function() {
    $("textarea").flexible();
});

function changeHeight() {
  $('#mapDiv').height($('#showImg').height());
}

$(document).ready(function(){
  var styles = {
    background: "#EEE",
    position: "static",
    width: "100%",
    marginLeft: "0",
    marginRight: "0"
  };
  $( ".showJumbo" ).prev().prev().css(styles);
  changeHeight();
})

$(window).resize(function(){
  changeHeight();
})

// function chooseModal(object, object_url){
//   $.ajax({
//     method: "GET",
//     url: "/courts",
//     data: {object: object, object_url: object_url}})
//     .done(function(msg){
//     })
//   }
;
/**
* jquery-match-height master by @liabru
* http://brm.io/jquery-match-height/
* License: MIT
*/


;(function(factory) { // eslint-disable-line no-extra-semi
    'use strict';
    if (typeof define === 'function' && define.amd) {
        // AMD
        define(['jquery'], factory);
    } else if (typeof module !== 'undefined' && module.exports) {
        // CommonJS
        module.exports = factory(require('jquery'));
    } else {
        // Global
        factory(jQuery);
    }
})(function($) {
    /*
    *  internal
    */

    var _previousResizeWidth = -1,
        _updateTimeout = -1;

    /*
    *  _parse
    *  value parse utility function
    */

    var _parse = function(value) {
        // parse value and convert NaN to 0
        return parseFloat(value) || 0;
    };

    /*
    *  _rows
    *  utility function returns array of jQuery selections representing each row
    *  (as displayed after float wrapping applied by browser)
    */

    var _rows = function(elements) {
        var tolerance = 1,
            $elements = $(elements),
            lastTop = null,
            rows = [];

        // group elements by their top position
        $elements.each(function(){
            var $that = $(this),
                top = $that.offset().top - _parse($that.css('margin-top')),
                lastRow = rows.length > 0 ? rows[rows.length - 1] : null;

            if (lastRow === null) {
                // first item on the row, so just push it
                rows.push($that);
            } else {
                // if the row top is the same, add to the row group
                if (Math.floor(Math.abs(lastTop - top)) <= tolerance) {
                    rows[rows.length - 1] = lastRow.add($that);
                } else {
                    // otherwise start a new row group
                    rows.push($that);
                }
            }

            // keep track of the last row top
            lastTop = top;
        });

        return rows;
    };

    /*
    *  _parseOptions
    *  handle plugin options
    */

    var _parseOptions = function(options) {
        var opts = {
            byRow: true,
            property: 'height',
            target: null,
            remove: false
        };

        if (typeof options === 'object') {
            return $.extend(opts, options);
        }

        if (typeof options === 'boolean') {
            opts.byRow = options;
        } else if (options === 'remove') {
            opts.remove = true;
        }

        return opts;
    };

    /*
    *  matchHeight
    *  plugin definition
    */

    var matchHeight = $.fn.matchHeight = function(options) {
        var opts = _parseOptions(options);

        // handle remove
        if (opts.remove) {
            var that = this;

            // remove fixed height from all selected elements
            this.css(opts.property, '');

            // remove selected elements from all groups
            $.each(matchHeight._groups, function(key, group) {
                group.elements = group.elements.not(that);
            });

            // TODO: cleanup empty groups

            return this;
        }

        if (this.length <= 1 && !opts.target) {
            return this;
        }

        // keep track of this group so we can re-apply later on load and resize events
        matchHeight._groups.push({
            elements: this,
            options: opts
        });

        // match each element's height to the tallest element in the selection
        matchHeight._apply(this, opts);

        return this;
    };

    /*
    *  plugin global options
    */

    matchHeight.version = 'master';
    matchHeight._groups = [];
    matchHeight._throttle = 80;
    matchHeight._maintainScroll = false;
    matchHeight._beforeUpdate = null;
    matchHeight._afterUpdate = null;
    matchHeight._rows = _rows;
    matchHeight._parse = _parse;
    matchHeight._parseOptions = _parseOptions;

    /*
    *  matchHeight._apply
    *  apply matchHeight to given elements
    */

    matchHeight._apply = function(elements, options) {
        var opts = _parseOptions(options),
            $elements = $(elements),
            rows = [$elements];

        // take note of scroll position
        var scrollTop = $(window).scrollTop(),
            htmlHeight = $('html').outerHeight(true);

        // get hidden parents
        var $hiddenParents = $elements.parents().filter(':hidden');

        // cache the original inline style
        $hiddenParents.each(function() {
            var $that = $(this);
            $that.data('style-cache', $that.attr('style'));
        });

        // temporarily must force hidden parents visible
        $hiddenParents.css('display', 'block');

        // get rows if using byRow, otherwise assume one row
        if (opts.byRow && !opts.target) {

            // must first force an arbitrary equal height so floating elements break evenly
            $elements.each(function() {
                var $that = $(this),
                    display = $that.css('display');

                // temporarily force a usable display value
                if (display !== 'inline-block' && display !== 'flex' && display !== 'inline-flex') {
                    display = 'block';
                }

                // cache the original inline style
                $that.data('style-cache', $that.attr('style'));

                $that.css({
                    'display': display,
                    'padding-top': '0',
                    'padding-bottom': '0',
                    'margin-top': '0',
                    'margin-bottom': '0',
                    'border-top-width': '0',
                    'border-bottom-width': '0',
                    'height': '100px',
                    'overflow': 'hidden'
                });
            });

            // get the array of rows (based on element top position)
            rows = _rows($elements);

            // revert original inline styles
            $elements.each(function() {
                var $that = $(this);
                $that.attr('style', $that.data('style-cache') || '');
            });
        }

        $.each(rows, function(key, row) {
            var $row = $(row),
                targetHeight = 0;

            if (!opts.target) {
                // skip apply to rows with only one item
                if (opts.byRow && $row.length <= 1) {
                    $row.css(opts.property, '');
                    return;
                }

                // iterate the row and find the max height
                $row.each(function(){
                    var $that = $(this),
                        style = $that.attr('style'),
                        display = $that.css('display');

                    // temporarily force a usable display value
                    if (display !== 'inline-block' && display !== 'flex' && display !== 'inline-flex') {
                        display = 'block';
                    }

                    // ensure we get the correct actual height (and not a previously set height value)
                    var css = { 'display': display };
                    css[opts.property] = '';
                    $that.css(css);

                    // find the max height (including padding, but not margin)
                    if ($that.outerHeight(false) > targetHeight) {
                        targetHeight = $that.outerHeight(false);
                    }

                    // revert styles
                    if (style) {
                        $that.attr('style', style);
                    } else {
                        $that.css('display', '');
                    }
                });
            } else {
                // if target set, use the height of the target element
                targetHeight = opts.target.outerHeight(false);
            }

            // iterate the row and apply the height to all elements
            $row.each(function(){
                var $that = $(this),
                    verticalPadding = 0;

                // don't apply to a target
                if (opts.target && $that.is(opts.target)) {
                    return;
                }

                // handle padding and border correctly (required when not using border-box)
                if ($that.css('box-sizing') !== 'border-box') {
                    verticalPadding += _parse($that.css('border-top-width')) + _parse($that.css('border-bottom-width'));
                    verticalPadding += _parse($that.css('padding-top')) + _parse($that.css('padding-bottom'));
                }

                // set the height (accounting for padding and border)
                $that.css(opts.property, (targetHeight - verticalPadding) + 'px');
            });
        });

        // revert hidden parents
        $hiddenParents.each(function() {
            var $that = $(this);
            $that.attr('style', $that.data('style-cache') || null);
        });

        // restore scroll position if enabled
        if (matchHeight._maintainScroll) {
            $(window).scrollTop((scrollTop / htmlHeight) * $('html').outerHeight(true));
        }

        return this;
    };

    /*
    *  matchHeight._applyDataApi
    *  applies matchHeight to all elements with a data-match-height attribute
    */

    matchHeight._applyDataApi = function() {
        var groups = {};

        // generate groups by their groupId set by elements using data-match-height
        $('[data-match-height], [data-mh]').each(function() {
            var $this = $(this),
                groupId = $this.attr('data-mh') || $this.attr('data-match-height');

            if (groupId in groups) {
                groups[groupId] = groups[groupId].add($this);
            } else {
                groups[groupId] = $this;
            }
        });

        // apply matchHeight to each group
        $.each(groups, function() {
            this.matchHeight(true);
        });
    };

    /*
    *  matchHeight._update
    *  updates matchHeight on all current groups with their correct options
    */

    var _update = function(event) {
        if (matchHeight._beforeUpdate) {
            matchHeight._beforeUpdate(event, matchHeight._groups);
        }

        $.each(matchHeight._groups, function() {
            matchHeight._apply(this.elements, this.options);
        });

        if (matchHeight._afterUpdate) {
            matchHeight._afterUpdate(event, matchHeight._groups);
        }
    };

    matchHeight._update = function(throttle, event) {
        // prevent update if fired from a resize event
        // where the viewport width hasn't actually changed
        // fixes an event looping bug in IE8
        if (event && event.type === 'resize') {
            var windowWidth = $(window).width();
            if (windowWidth === _previousResizeWidth) {
                return;
            }
            _previousResizeWidth = windowWidth;
        }

        // throttle updates
        if (!throttle) {
            _update(event);
        } else if (_updateTimeout === -1) {
            _updateTimeout = setTimeout(function() {
                _update(event);
                _updateTimeout = -1;
            }, matchHeight._throttle);
        }
    };

    /*
    *  bind events
    */

    // apply on DOM ready event
    $(matchHeight._applyDataApi);

    // use on or bind where supported
    var on = $.fn.on ? 'on' : 'bind';

    // update heights on load and resize events
    $(window)[on]('load', function(event) {
        matchHeight._update(false, event);
    });

    // throttled update heights on resize events
    $(window)[on]('resize orientationchange', function(event) {
        matchHeight._update(true, event);
    });

});
/*!
* flexibleArea.js v1.3
* A jQuery plugin that dynamically updates textarea's height to fit the content.
* http://flaviusmatis.github.com/flexibleArea.js/
*
* Copyright 2012, Flavius Matis
* Released under the MIT license.
* http://flaviusmatis.github.com/license.html
*/


(function($){
	var methods = {
		init : function() {

			var styles = [
				'paddingTop',
				'paddingRight',
				'paddingBottom',
				'paddingLeft',
				'fontSize',
				'lineHeight',
				'fontFamily',
				'width',
				'fontWeight',
				'border-top-width',
				'border-right-width',
				'border-bottom-width',
				'border-left-width',
				'-moz-box-sizing',
				'-webkit-box-sizing',
				'box-sizing'
			];

			return this.each(function(){

				if (this.type !== 'textarea')	return false;
					
				var $textarea = $(this).css({'resize': 'none', overflow: 'hidden'});
				
				var	$clone = $('<div></div>').css({
					'position' : 'absolute',
					'display' : 'none',
					'word-wrap' : 'break-word',
					'white-space' : 'pre-wrap',
					'border-style' : 'solid'
				}).appendTo(document.body);

				function copyStyles(){
					for (var i=0; i < styles.length; i++) {
						$clone.css(styles[i],$textarea.css(styles[i]));
					}
				}

				// Apply textarea styles to clone
				copyStyles();

				var hasBoxModel = $textarea.css('box-sizing') == 'border-box' || $textarea.css('-moz-box-sizing') == 'border-box' || $textarea.css('-webkit-box-sizing') == 'border-box';
				var heightCompensation = parseInt($textarea.css('border-top-width')) + parseInt($textarea.css('padding-top')) + parseInt($textarea.css('padding-bottom')) + parseInt($textarea.css('border-bottom-width'));
				var textareaHeight = parseInt($textarea.css('height'), 10);
				var lineHeight = parseInt($textarea.css('line-height'), 10) || parseInt($textarea.css('font-size'), 10);
				var minheight = lineHeight * 2 > textareaHeight ? lineHeight * 2 : textareaHeight;
				var maxheight = parseInt($textarea.css('max-height'), 10) > -1 ? parseInt($textarea.css('max-height'), 10) : Number.MAX_VALUE;

				function updateHeight() {
					var textareaContent = $textarea.val().replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/&/g, '&amp;').replace(/\n/g, '<br/>');
					// Adding an extra white space to make sure the last line is rendered.
					$clone.html(textareaContent + '&nbsp;').css({'width': parseInt($textarea.width(), 10) + 'px'});
					setHeightAndOverflow();
				}

				function setHeightAndOverflow(){
					var cloneHeight = $clone.height();
					var overflow = 'hidden';
					var height = hasBoxModel ? cloneHeight + lineHeight + heightCompensation : cloneHeight + lineHeight;
					if (height > maxheight) {
						height = maxheight;
						overflow = 'auto';
					} else if (height < minheight) {
						height = minheight;
					}
					if ($textarea.height() !== height) {
						$textarea.css({'overflow': overflow, 'height': height + 'px'});
					}
				}

				// Update textarea size on keyup, change, cut and paste
				$textarea.bind('keyup change cut paste', function(){
					updateHeight();
				});

				// Update textarea on window resize
				$(window).bind('resize', function(){
					if ($clone.width() !== parseInt($textarea.width(), 10)) {
						updateHeight();
					}
				});

				// Update textarea on blur
				$textarea.bind('blur',function(){
					setHeightAndOverflow();
				});

				// Update textarea when needed
				$textarea.bind('updateHeight', function(){
					copyStyles();
					updateHeight();
				});

				// Wait until DOM is ready to fix IE7+ stupid bug
				$(function(){
					updateHeight();
				});
			});
		}
	};

	$.fn.flexible = function(method) {
		// Method calling logic
		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || ! method) {
			return methods.init.apply(this, arguments);
		} else {
			$.error('Method ' + method + ' does not exist on jQuery.flexible');
		}
	};

})(jQuery);



