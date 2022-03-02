$(function() {

    // Submenu
    var allMenu = {
        init: function() {
            this.$tartet = $('.all_menu');
            this.$btn = $('.util_menu .allmenu');
            this.addEvent();
        },
        addEvent: function() {
            var objAllMenu = this.$tartet;
            this.$btn.on('click', function(e) {
                e.preventDefault();
                if (objAllMenu.is(':visible')) {
                    objAllMenu.slideUp(100);
                    $(this).removeClass('on');
                } else {
                    objAllMenu.slideDown(100);
                    $(this).addClass('on');
                }
            });
        }
    }
    $('.allmenu').length && allMenu.init();

    // Form

        // Checkbox
        $('.f_chk').on('keyup', function(e) {
            e.preventDefault();
            if (window.event.keyCode == 13) {
                $(this).toggleClass('on');
                if ( $(this).find('input').prop('checked') ) {
                    $(this).find('input').prop('checked', false);
                } else {
                    $(this).find('input').prop('checked', true);
                }
            }
        });
        $('.f_chk input').on('click', function(e) {
            e.preventDefault();
            $(this).parent().toggleClass('on');
        });

        var chkOnly = {
            init: function() {
                this.$tartet = $('.f_chk_only');
                this.addEvent();
            },
            addEvent: function() {
                this.$tartet.on('click', function() {
                    if ($(this).hasClass('on')) {
                        $(this).removeClass('on');
                        $(this).find('input').prop('checked', false);
                    } else {
                        $(this).addClass('on');
                        $(this).find('input').prop('checked', true);
                    }
                });
            }
        }
        $('.f_chk_only').length && chkOnly.init();

        var chkAll = {
            init: function() {
                this.$tartet = $('.chkAll');
                this.addEvent();
            },
            addEvent: function() {
                this.$tartet.on('click', function() {
                    var idx = $(this).parents('tr').find('th').index($(this).parent('th'));

                    if ($(this).hasClass('on')) {
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only').addClass('on');
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only input').prop('checked', true);
                    } else {
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only').removeClass('on');
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only input').prop('checked', false);
                    }
                });
            },
        }
        $('.chkAll').length && chkAll.init();

        // Radio
        $('.f_rdo').on('keyup', function(e) {
            e.preventDefault();
            if (window.event.keyCode == 13) {
                if ($(this).parents('.rdoSet') < 1) {
                    $(this).toggleClass('on');
                    if ( $(this).find('input').prop('checked') ) {
                        $(this).find('input').prop('checked', false);
                    } else {
                        $(this).find('input').prop('checked', true);
                    }
                } else {
                    $(this).parents('.rdoSet').find('.f_rdo').removeClass('on');
                    $(this).parents('.rdoSet').find('.f_rdo').prop('checked', false);
                    $(this).addClass('on');
                    $(this).find('input').prop('checked', true);
                }
            }
        });
        $('.f_rdo input').on('click', function() {
            if ($(this).parents('.rdoSet') < 1) {
                $(this).parent().toggleClass('on');
            } else {
                $(this).parents('.rdoSet').find('.f_rdo').removeClass('on');
                $(this).parent().addClass('on');
            }
        });



    
    // Main
        // dashboard tab
        $('.dash_board .tab li a').on('click', function(e) {
            e.preventDefault();
            $(this).addClass('cur');
            $(this).parent().siblings().find('a').removeClass('cur');

            var idx = $('.dash_board .tab li a').index(this);
            $('.dash_board .tab_contents .tab_item').hide();
            $('.dash_board .tab_contents .tab_item').eq(idx).show();
        });
    

    
    $('.popup').length && popup.init();
    
});

// Popup
var popup = {
    init: function() {
        this.$target = $('.popup');
        this.$close = this.$target.find('.pop_header .close');
        this.addEvent();
    },
    open: function(obj) {
        $('.' + obj).show();
    },
    addEvent: function() {
        this.$close.on('click', function() {
            $(this).parents('.popup').hide();
        });
    }
}