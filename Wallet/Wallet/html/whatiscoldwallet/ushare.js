(function($) {
	"use strict";

	var sinaUrlPrefix = 'http://service.weibo.com/share/'+(/android|webos|ip(hone|ad|od)|opera (mini|mobi|tablet)|iemobile|windows.+(phone|touch)|mobile|fennec|kindle (Fire)|Silk|maemo|blackberry|playbook|bb10\; (touch|kbd)|Symbian(OS)|Ubuntu Touch/i.test(navigator.userAgent)?'mobile':'share')+'.php?';

	// 获取Cookie
	function getCookie(key) {
		var c, s, j, cookies;
	    c = document.cookie.split('; ');
	    cookies = {};

	    for( var i = c.length-1; i>=0; i-- ){
	       s = c[i].split('=');
	       cookies[s[0]] = unescape(s[1]);
	    }
		
		if( cookies["ushare"] ) {
			j = $.parseJSON( cookies['ushare'] );
			if( j[key] )
				return j[key];
			else
				return false;
		} else {
			return false;
		}
	}

	// 微信二维码分享
	$('.u-qrcode').each(function(index, el) {
		var url = $(this).data('url');
		if($.fn.qrcode) {
			$(this).qrcode({
				text: url,
				width: 150,
				height: 150,
			});
		}
	});

	// 保存至印象笔记
	$('.u-network.evernote').on('click', function(event) {
		event.preventDefault();
		try {
			window.open($(this).attr('href'), 'weibo', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2)
		} catch(e) {
			console.log(e);
		}
	});

	// 推荐到豆瓣
	$('.u-network.douban').on('click', function(event) {
		event.preventDefault();
		var d  = document,
		    e  = encodeURIComponent,
		    s1 = window.getSelection,
		    s2 = d.getSelection,
		    s3 = d.selection,
		    s  = s1 ? s1() : s2 ? s2() : s3 ? s3.createRange().text:'',
		    r  = 'http://www.douban.com/recommend/?url='+ e(d.location.href) +'&title='+ e(d.title) +'&sel='+ e(s) +'&v=1',
		    w  = 450,
		    h  = 330,
		    x  = function() {
		        if(!window.open(r,'douban','toolbar=0,resizable=1,scrollbars=yes,status=1,width='+w+',height='+h+',left='+(screen.width-w)/2+',top='+(screen.height-h)/2))
		        	location.href = r + '&r=1'
		    };

		    if(/Firefox/.test(navigator.userAgent)){
		    	setTimeout(x,0)
		    }else{
		    	x()
		    }
	});

	// 分享到微博
	$('.u-network.weibo').on('click', function(event) {
		event.preventDefault();
		var key, urlArray = [], shareUrl = '';

		if(ushare.weibo_data) {
			for(key in ushare.weibo_data){
				if(ushare.weibo_data.hasOwnProperty(key)){
					switch(key){
						case 'url':
						case 'pic':
						case 'title':
							urlArray.push(key+'='+encodeURIComponent(ushare.weibo_data[key]))
							break;
						case 'ralateUid':
						case 'appkey':
							urlArray.push(key+'='+ushare.weibo_data[key])
							break;
					}
				}
			}
		}
		shareUrl = sinaUrlPrefix + urlArray.join('&');

		try {
			window.open(shareUrl, 'weibo', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2)
		} catch(e) {
			console.log(e);
		}
	});

	// 分享到腾讯微博
	$('.u-network.qq').on('click', function(event) {
		event.preventDefault();
		var _t = ushare.qq_data.title;  
		var _url = ushare.qq_data.url; 
		var _appkey = ushare.qq_data.appkey; 
		var _site = encodeURI; 
		var _pic = ushare.qq_data.pic; 
		var _u = 'http://v.t.qq.com/share/share.php?title='+_t+'&url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic; 
		window.open( _u,'qq', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2); 
	});

	// 分享到QQ空间
	$('.u-network.qzone').on('click', function(event) {
		event.preventDefault();
		if(ushare.qzone_data) {
			var s = [];
			for(var i in ushare.qzone_data){
				s.push(i + '=' + encodeURIComponent(ushare.qzone_data[i]||''));
			}
			var _u = 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?' + s.join('&'); 
		}
		window.open( _u,'qzone', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2); 
	});

	// 分享到人人
	$('.u-network.renren').on('click', function(event) {
		event.preventDefault();
		if(ushare.renren_data) {
			var submitUrl = 'http://widget.renren.com/dialog/share';
			var p = ushare.renren_data;
			var prm = [];
			for (var i in p) {
				if (p[i])
					prm.push(i + '=' + encodeURIComponent(p[i]));
			}

			var url = submitUrl+"?" + prm.join('&');

			try {
				window.open( url,'renren', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2); 
			} catch(e) {
				console.log(e);
			}
		}
		
	});

	// 分享到Facebook
	$('.u-network.facebook').on('click', function(event) {
		event.preventDefault();
		if(ushare.facebook_data) {
			var submitUrl = 'http://www.facebook.com/sharer.php';
			var p = ushare.facebook_data;
			var prm = [];
			for (var i in p) {
				if (p[i])
					prm.push(i + '=' + encodeURIComponent(p[i]));
			}

			var url = submitUrl + "?" + prm.join('&');

			try {
				window.open( url,'facebook', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2); 
			} catch(e) {
				console.log(e);
			}
		}
		
	});

	// 分享到Twitter
	$('.u-network.twitter').on('click', function(event) {
		event.preventDefault();
		if(ushare.twitter_data) {
			var submitUrl = 'http://twitter.com/share';
			var p = ushare.twitter_data;
			var prm = [];
			for (var i in p) {
				if (p[i])
					prm.push(i + '=' + encodeURIComponent(p[i]));
			}

			var url = submitUrl + "?" + prm.join('&');

			try {
				window.open( url,'twitter', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2); 
			} catch(e) {
				console.log(e);
			}
		}
		
	});

	// 分享到Google+
	$('.u-network.googleplus').on('click', function(event) {
		event.preventDefault();
		if(ushare.googleplus_data) {
			var submitUrl = 'https://plus.google.com/share';
			var p = ushare.googleplus_data;
			var prm = [];
			for (var i in p) {
				if (p[i])
					prm.push(i + '=' + encodeURIComponent(p[i]));
			}

			var url = submitUrl + "?" + prm.join('&');

			try {
				window.open( url,'google+', 'toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330,left='+(screen.width-450)/2+',top='+(screen.height-330)/2); 
			} catch(e) {
				console.log(e);
			}
		}
		
	});

	// 点赞
	$('.u-network.likes').on('click', function(event) {
		event.preventDefault();
		var p_id = $(this).data('id'), $this = $(this), cookies = getCookie("likes"), liked;

		// 验证Cookie
		if( cookies ) {
			$.each( cookies, function(index, value) {
				if(p_id == value) {
					liked = true;
				}
			});
		}
		if( liked ) {
			alert('你已经赞过此文章了！');
			return;
		}

		// 点赞发送
		$.ajax({
			url: ushare_object.ajaxurl,
			type: 'POST',
			dataType: 'json',
			data: { action: 'ushare_likeit',post_id: p_id, nonce: ushare_object.likes_nonce},
		})
		.done(function(response) {
			if(response.status == '1') {
				$('.u-network.likes .count').each(function() {
					$(this).html(response.count);
				});
			} else if(response.status == '-1') {
				console.log('error');
			}
		});
		
	});

	// 刷新点赞计数, 避免静态化缓存造成不能即时显示数量
	$('.u-network.likes').each(function(index, el) {
		var p_id = $(this).data('id'), $this = $(this);
		$.ajax({
			url: ushare_object.ajaxurl,
			type: 'POST',
			dataType: 'json',
			data: { action: 'ushare_getlikes', post_id: p_id},
		})
		.done(function(response) {
			if(response.status == '1') {
				$this.find('.count').html(response.count);
			}
		});
	});
	
	$(document).click(function(e) {
		$('.u-network.share.active').each(function() {
			if(e.target !== this && !$(this).has(e.target).length) {
				$(this).find('.u-tooltip').stop().fadeOut('fast');
				$(this).removeClass('active');
			}
		});
	});
	$('.u-network.share > .u-icon-wrap').on('click', function(event) {
		event.preventDefault();
		var $this = $(this).closest('.u-network');
		if( ! $this.hasClass('active') ) {
			$this.find('.u-tooltip').stop().fadeIn('fast');
			$this.addClass('active');
		} else {
			$this.find('.u-tooltip').stop().fadeOut('fast');
			$this.removeClass('active');
		}
	});
	

	// 吸附侧栏位置修正
	function set_sidebar_position(){
		if( $( '.u-side' ).length ){
			var $sidebar = $( '.u-side' ),
				top_position = $( window ).height() / 2 - $sidebar.innerHeight() / 2;
				top_position = 0 > top_position ? 0 : top_position;
			$sidebar.stop().animate({ top: top_position });
		}
	}
	set_sidebar_position();

	$(window).resize(function(event) {
		set_sidebar_position();
	});

	// 分享窗口检测
	$(document).ready(function() {
		if($('.u-float-trigger').length) {
			$(window).scroll(function() {
				if($(window).scrollTop() + $(window).height() > $('.u-float-trigger').offset().top - 100) {
			   		$('.u-notification').addClass('show_animated');
				}
			});
		}
	});

	$('.u-notification .js-close').on('click', function(event) {
		event.preventDefault();
		var $p = $(this).closest('.u-notification');
		$p.addClass( 'hide_fadeout' );
		setTimeout( function() {
			$p.remove();
		}, 800 );
	});

	// 返回到顶部
	$('.u-network.backup').on('click', function(event) {
		event.preventDefault();
		var top = $('body').scrollTop();
		if( top != 0 ) {
		  $('body').animate({scrollTop:0}, '500');
		}
	});

})(jQuery);