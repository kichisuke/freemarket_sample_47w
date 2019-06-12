$(function() {
  $('.tab-news').click(function() {
    $('.tab-news.tab-active').removeClass('tab-active');
    $(this).addClass('tab-active');
    $(".tab-news-content.tab-show").removeClass('tab-show');
        // クリックしたタブからインデックス番号を取得
    const index = $(this).index();
        // クリックしたタブと同じインデックス番号をもつコンテンツを表示
    $(".tab-news-content").eq(index).addClass('tab-show');
  });

  $('.tab-buy').click(function() {
    $('.tab-buy.tab-active').removeClass('tab-active');
    $(this).addClass('tab-active');
    $(".tab-buy-content.tab-show").removeClass('tab-show');
    const index = $(this).index();
    $(".tab-buy-content").eq(index).addClass('tab-show');
  });

  $('.mypage-side__lists__link').click(function() {
    $('.mypage-side__lists__link.list-active').removeClass('list-active');
    $(this).addClass('list-active');
  });
});
