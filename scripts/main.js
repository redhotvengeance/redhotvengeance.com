(function() {
  function setMessage() {
    var messages = $('.message-bar > h1');

    if ($('.message-bar').length > 0) {
      var randomMessageIndex = Math.floor(Math.random() * messages.length);
      for (var i = 0; i < messages.length; i++) {
        $(messages[i]).hide();

        if (i === randomMessageIndex) {
          $(messages[i]).show();
        }
      }
    }
  }

  function setAbout() {
    if ($('.about-content').length > 0) {
      // i do
      var iWrite = $('#i-write > li');
      var iLike = $('#i-like > li');
      var iUse = $('#i-use > li');

      iWrite.hide();
      iLike.hide();
      iUse.hide();

      iWrite = _.shuffle(iWrite);
      iLike = _.shuffle(iLike);
      iUse = _.shuffle(iUse);

      rotateItemList(iWrite, 0, .65);
      rotateItemList(iLike, 250, .65);
      rotateItemList(iUse, 500, .65);

      // i live
      var myWife = $('#my-wife > li');
      var myCorgi = $('#my-corgi > li');
      var myCat = $('#my-cat > li');

      myWife.hide();
      myCorgi.hide();
      myCat.hide();

      myWife = _.shuffle(myWife);
      myCorgi = _.shuffle(myCorgi);
      myCat = _.shuffle(myCat);

      rotateItemList(myWife, 0, 0);
      rotateItemList(myCorgi, 0, 0);
      rotateItemList(myCat, 0, 0);

      // my work
      var myWork = $('#my-work > li');
      myWork.hide();
      myWork = _.shuffle(myWork);
      rotateItemList(myWork, 0, 0);
    }
  }

  function rotateItemList(itemList, delay, duration) {
    setTimeout(function() {
      $(itemList[0]).css("top", -$(itemList[0]).height());
      $(itemList[0]).show();
      TweenLite.to($(itemList[itemList.length - 1]), duration, {css:{top:$(itemList[0]).height()}, ease:Back.easeInOut, onComplete:hideItem, onCompleteParams:[$(itemList[itemList.length - 1])]});
      TweenLite.to($(itemList[0]), duration, {css:{top:0}, ease:Back.easeInOut});
      itemList.push(itemList.splice(0, 1)[0]);
      rotateItemList(itemList, (Math.random() * 5000) + 2000, .65);
    }, delay);
  }

  function hideItem(item) {
    $(item).hide();
  }

  $(document).ready(function() {
    setMessage();
    setAbout();
	});
}).call(this);
