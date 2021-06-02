
				init:				function(){
				
					return this.each( function(){
					
						/* variables */
						
						var s, slider, api;
					
						/* fill them */
						
						slider		= $(this).css('position','relative');
						api			= new Object();
						
						api.options = $.extend( defaults, options );
						s			= api.options;
						
						typeof s.start == 'object' ? 1 : s.start=[s.start];
						
						/* Available elements */
						
						api.slider	= slider;
						api.low		= $('<div class="noUi-handle noUi-lowerHandle"><div></div></div>');
						api.up		= $('<div class="noUi-handle noUi-upperHandle"><div></div></div>');
						api.connect	= $('<div class="noUi-midBar"></div>');
						
						/* Append the middle bar */
						
						s.connect ? api.connect.appendTo(api.slider) : api.connect = false;
						
						/* Append the handles */
						
						// legacy rename
						if(s.knobs){
							s.handles=s.knobs;
						}
						
						if ( s.handles === 1 ){
						
							/*
								This always looks weird:
								Connect=lower, means activate upper, because the bar connects to 0.
							*/
						
							if ( s.connect === true || s.connect === 'lower' ){
							
								api.low		= false;
								api.up		= api.up.appendTo(api.slider);
								api.handles	= [api.up];
								
							} else if ( s.connect === 'upper' || !s.connect ) {
							
								api.low		= api.low.prependTo(api.slider);
								api.up		= false;
								api.handles	= [api.low];
							
							}
							
						} else {
						
							api.low		= api.low.prependTo(api.slider);
							api.up		= api.up.appendTo(api.slider);
							api.handles	= [api.low, api.up];
						
						}
						
						if(api.low){ api.low.left = helpers.left; }
						if(api.up){ api.up.left = helpers.left; }
						
						api.slider.children().css('position','absolute');
						
						$.each( api.handles, function( index ){
						
							$(this).css({
								'left' : helpers.scale(s.start[index],api.options.scale,api.slider.innerWidth()),
								'zIndex' : index + 1
							}).children().bind(touch?'touchstart.noUi':'mousedown.noUi',functions.start);
						
						});
						
						if(s.click){
							api.slider.click(functions.click).find('*:not(.noUi-midBar)').click(functions.flse);
						}
						
						helpers.connect(api);

						/* expose */
						api.options=s;
						api.slider.data('api',api);
					
					});
				
				},
				move:				function(){
				
					var api, bounce, to, handle, scale;
					
					api = dup($(this).data('api'));
					api.options = $.extend( api.options, options );

					// rename legacy 'knob'
					if(api.options.knob){
						api.options.handle = api.options.knob;
					}
					
					// flatten out the legacy 'lower/upper' options
					handle	= api.options.handle;
					handle	= api.handles[handle == 'lower' || handle == 0 || typeof handle == 'undefined' ? 0 : 1];
					bounce	= helpers.bounce(api, helpers.scale(api.options.to, api.options.scale, api.slider.innerWidth()), handle.left(), handle);
					
					handle.css('left',bounce[0]);
					
					if( (handle.is(api.up) && handle.left() == 0) || (handle.is(api.low) && handle.left() == api.slider.innerWidth()) ){
						handle.css('zIndex',parseInt(handle.css('zIndex'))+2);
					}
					
					if(options.save===true){
						api.options.scale = options.scale;
						$(this).data('api',api);
					}
					
					helpers.connect(api);
					helpers.call(api.options.change, api.slider, 'move');
					helpers.call(api.options.end, api.slider, 'move');
					
				},
				value:				function(){
				
					var val1, val2, api;
					
					api = dup($(this).data('api'));
					api.options = $.extend( api.options, options );
					
					val1	= api.low ? Math.round(helpers.deScale(api.low.left(), api.options.scale, api.slider.innerWidth()))  : false;
					val2	= api.up ? Math.round(helpers.deScale(api.up.left(), api.options.scale, api.slider.innerWidth()))  : false;
					
					if(options.save){
						api.options.scale = options.scale;
						$(this).data('api',api);
					}
					
					return [val1,val2];
				
				},
				api:				function(){
					return $(this).data('api');
				},
				disable:			function(){
					return this.each( function(){
						$(this).addClass('disabled');
					});
				},
				enable:				function(){
					return this.each( function(){
						$(this).removeClass('disabled');
					});
				}

			},