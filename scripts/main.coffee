---
---
$(document).ready =>
  ## messages ##
  messages = $('.message-bar > h1')
  randomMessageIndex = Math.floor(Math.random() * messages.length)
  messages.each (index) ->
    if index isnt randomMessageIndex
      $(@).hide()

  ## i do ##
  $('.about-i-do > ul > li > ul').css('width', '190px')
  $('.about-i-do > ul > li > ul').css('height', '72px')
  $('.about-i-do > ul > li > ul').css('overflow', 'hidden')
  $('.about-i-do > ul > li > ul').css('position', 'relative')
  $('.about-i-do > ul > li > ul > li').css('position', 'absolute')

  iWrite = $('#i-write > li')
  iLike = $('#i-like > li')
  iUse = $('#i-use > li')

  iWrite.hide()
  iLike.hide()
  iUse.hide()

  iWrite = _.shuffle(iWrite)
  iLike = _.shuffle(iLike)
  iUse = _.shuffle(iUse)

  rotateItemList(iWrite, 0)
  rotateItemList(iLike, 250)
  rotateItemList(iUse, 500)

  ## i live ##
  $('.about-i-live-with-my-wife > ul').css('width', '115px')
  $('.about-i-live-with-my-wife > ul').css('height', '21px')
  $('.about-i-live-with-my-wife > ul').css('overflow', 'hidden')
  $('.about-i-live-with-my-wife > ul').css('position', 'relative')
  $('.about-i-live-with-my-wife > ul > li').css('position', 'absolute')

  $('.about-i-live-with-my-corgi > ul').css('width', '140px')
  $('.about-i-live-with-my-corgi > ul').css('height', '21px')
  $('.about-i-live-with-my-corgi > ul').css('overflow', 'hidden')
  $('.about-i-live-with-my-corgi > ul').css('position', 'relative')
  $('.about-i-live-with-my-corgi > ul > li').css('position', 'absolute')

  $('.about-i-live-with-my-cat > ul').css('width', '95px')
  $('.about-i-live-with-my-cat > ul').css('height', '17px')
  $('.about-i-live-with-my-cat > ul').css('overflow', 'hidden')
  $('.about-i-live-with-my-cat > ul').css('position', 'relative')
  $('.about-i-live-with-my-cat > ul > li').css('position', 'absolute')

  myWife = $('#my-wife > li')
  myCorgi = $('#my-corgi > li')
  myCat = $('#my-cat > li')

  myWife.hide()
  myCorgi.hide()
  myCat.hide()

  myWife = _.shuffle(myWife)
  myCorgi = _.shuffle(myCorgi)
  myCat = _.shuffle(myCat)

  rotateItemList(myWife, 0, 0)
  rotateItemList(myCorgi, 0, 0)
  rotateItemList(myCat, 0, 0)

rotateItemList = (itemList, delay, duration = .65) =>
  setTimeout =>
    $(itemList[0]).css("top", -$(itemList[0]).height())
    $(itemList[0]).show()
    TweenLite.to $(itemList[itemList.length - 1]), duration, {css:{top:$(itemList[0]).height()}, ease:Back.easeInOut}
    TweenLite.to $(itemList[0]), duration, {css:{top:0}, ease:Back.easeInOut}
    itemList.push(itemList.splice(0, 1)[0])
    rotateItemList(itemList, (Math.random() * 5000) + 2000)
  , delay
