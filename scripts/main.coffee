---
---

$(document).ready =>
  ## messages ##
  if $('.message-bar').length > 0
    messages = $('.message-bar > h1')
    randomMessageIndex = Math.floor(Math.random() * messages.length)
    messages.each (index) ->
      $(@).hide()

      if index is randomMessageIndex
        $(@).show()

  ## about ##
  if $('.about-content').length > 0
    ## i do ##
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

    ## my work ##
    myWork = $('#my-work > li')
    myWork.hide()
    myWork = _.shuffle(myWork)
    rotateItemList(myWork, 0, 0)

rotateItemList = (itemList, delay, duration = .65) =>
  setTimeout =>
    $(itemList[0]).css("top", -$(itemList[0]).height())
    $(itemList[0]).show()
    TweenLite.to $(itemList[itemList.length - 1]), duration, {css:{top:$(itemList[0]).height()}, ease:Back.easeInOut, onComplete:hideItem, onCompleteParams:[$(itemList[itemList.length - 1])]}
    TweenLite.to $(itemList[0]), duration, {css:{top:0}, ease:Back.easeInOut}
    itemList.push(itemList.splice(0, 1)[0])
    rotateItemList(itemList, (Math.random() * 5000) + 2000)
  , delay

hideItem = (item) =>
  $(item).hide()
