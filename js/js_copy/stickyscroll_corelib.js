(function(b)
{
	var a=function(h,k)
	{
		var w=b(h);var l=this;var A=
		{
			container:"#container",minTopDistance:0,fadeSpeed:200,scrollSpeed:800,internalSpeed:1,layer_id:"StickyScrollLayer",ieOffset:0,cssOption:
			{
				display:"block",position:"absolute",margin:"0",padding:"0",zIndex:"9",height:"auto",width:"auto"
			}
			,position:
			{
				mode:"auto",of:b("body"),my:"left top",at:"left top",offset:"0 0",collision:"none none"
			}
			,markup_content_selector:".content",markup:'<div class="stickyLayer"><div class="content"></div></div>',enableConsoleLog:false
		};var r;var c;this.update=function()
		{
			z()
		};this.setToStatic=function(B)
		{
			q(B)
		};this.setToAbsolute=function(B)
		{
			t(B)
		};this.destroy=function()
		{
			j()
		};this.close=function(C,B)
		{
			o(C,B)
		};var Y=function(B)
		{
			b("html, body").animate(
			{
				scrollTop:B,avoidTransforms:true
			}
			,
			{
				duration:A.internalSpeed,queue:false,specialEasing:"linear",complete:function()
				{
					m("sticky is on the bottom of page")
				}
				
			}
			)
		};var y=function(C,B)
		{
			return(typeof(C)!=="undefined"&&C!==null)?C:B
		};var z=function()
		{
			d();if(A.position.mode!=="manual")
			{
				n()
			}
			
		};var n=function()
		{
			if(b(window).scrollTop()>=A.minTopDistance)
			{
				r.stop().animate(
				{
					top:(b(window).scrollTop()+b(window).height()-(r.height()+A.ieOffset)),avoidTransforms:true
				}
				,
				{
					duration:A.scrollSpeed,queue:false,specialEasing:"swing",complete:function()
					{
						m("sticky is on the bottom"+(b(window).scrollTop()+b(window).height()-(r.height()+A.ieOffset)))
					}
					
				}
				)
			}
			
		};var s=function()
		{
			r.position(
			{
				of:A.position.of,my:A.position.my,at:A.position.at,offset:A.position.offset,collision:A.position.collision
			}
			)
		};var d=function()
		{
			if(b(window).scrollTop()>=A.minTopDistance)
			{
				p(m("sticky is visible"))
			}
			else
			{
				o(0,m("sticky is not visible"))
			}
			
		};var g=function()
		{
			b(window).on("load.stickyScroll",function()
			{
				z()
			}
			);b(window).on("scroll.stickyScroll",function()
			{
				z()
			}
			);b(window).on("resize.stickyScroll",function()
			{
				z()				
			}
			)
		};var u=function()
		{
			b(window).off("load.stickyScroll");b(window).off("scroll.stickyScroll");b(window).off("resize.stickyScroll")
		};var p=function(B)
		{
			i(1,B)
		};var o=function(B,D)
		{
			if(typeof(B)!=="undefined"&&B!==null&&B>0)
			{
				var C=setTimeout(function()
				{
					i(0,D);j();clearTimeout(C)
				}
				,B)
			}
			else
			{
				i(0,D);j()
			}
			
		};var i=function(B,C)
		{
			r.fadeTo(A.fadeSpeed,B,"swing",function()
			{
				v(C)
			}
			)
		};var x=function()
		{
			if(k)
			{
				b.extend(true,A,k)
			}
			if(A.markup.length>0)
			{
				r=b(A.markup,
				{
					id:A.layer_id
				}
				);r.find(A.markup_content_selector).append(w)
			}
			else
			{
				r=b("<div/>",
				{
					id:A.layer_id
				}
				).append(w)
			}
			r.css(A.cssOption).appendTo(A.container);c=document.documentElement.clientWidth/window.innerWidth;
			s();g()
		};var v=function(B)
		{
			if(f(B))
			{
				B()
			}
			
		};var f=function(B)
		{
			if((typeof(B)!=="undefined")&&(B!==null))
			{
				return true
			}
			else
			{
				return false
			}
			
		};var m=function(B)
		{
			if(A.enableConsoleLog)
			{
				console.log(B)
			}
			
		};var j=function()
		{
			r.remove();u()
		};x()
	};b.fn.stickyScroll=function(c)
	{
		return this.each(function()
		{
			var d=b(this);if(d.data("stickyScroll"))
			{
				return
			}
			var g=new a(this,c);d.data("stickyScroll",g)
		}
		)
	}
	
}
)(jQuery);
try
{
	(function site(b)
	{
		var m=true,i,n=0,v=false,j=function()
		{
			b("#layerFirstVisit #closeLayer").on("click",function(w)
			{
				if(typeof b("#layerFirstVisit").data("stickyScroll")!=="undefined")
				{
					b("#layerFirstVisit").data("stickyScroll").close()
				}
				w.preventDefault();w.stopPropagation()
			}
			);b("#userBar, #header, #mainContainer, #footer").on("click",function()
			{
				if(v)
				{
					if(typeof b("#layerFirstVisit").data("stickyScroll")!=="undefined")
					{
						b("#layerFirstVisit").data("stickyScroll").setToAbsolute(n)
					}
					v=false
				}
				
			}
			);			
		}
		,g=function(w)
		{
			w.appendTo("body");b("#layerFirstVisit").stickyScroll(
			{
				container:"body",minTopDistance:0,fadeSpeed:200,scrollSpeed:800,ieOffset:-1,cssOption:
				{
					zIndex:"99999",width:"100%"
				}
				,position:
				{
					mode:"auto",of:b("body"),my:"right bottom",at:"right bottom"
				}
				
			}
			);if(b("#layerFirstVisit form").length>0)
			{
				b.validator.unobtrusive.parse("#"+b("#layerFirstVisit form")[0].id)
			}
			
		}
		,d=function()
		{
			var w=$Y.cookie.get(window.jsInit.links.Ver,"LAYERFIRSTVISIT");
			if((!w||w!=="True")&&(window.jsInit.links.LayerFirstVisit&&window.jsInit.links.LayerFirstVisit.length>0))
			{
				var x=b("<div/>");
				x.load(window.jsInit.links.LayerFirstVisit,function()
				{
					g(x);
					j();
					$Y.cookie.setProps(window.jsInit.links.Ver,
					{
						LAYERFIRSTVISIT:"True"
					}
					,90)
				}
				);
			}
			
		}
		,s=function()
		{
			if(window.jsInit.isLayerFirstVisitDisabled!=="True")
			{
				d()
			}
			
		};
		b(document).ready(function()
		{
			s();
			
		}
		)
	}
	)(jQuery)
}
catch(e)
{
};
