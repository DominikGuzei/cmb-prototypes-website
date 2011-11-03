#= require_tree ./components
#= require_tree ./gravity_switch

class Game
  
  @TILE_SIZE: 30
  @TILES_X: 40
  @TILES_Y: 20
  @VIEWPORT_WIDTH: 30 * 40
  @VIEWPORT_HEIGHT: 30 * 20
  
  @LEVEL: [
    [1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,1,1,0,0, 0,0,0,0,0, 0,0,0,1,0, 0,0,0,0,0, 1,0,0,0,0, 0,0,0,1,4],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 1,0,0,0,0, 0,0,0,0,4],
    [1,1,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 1,0,0,0,0, 0,0,0,0,4],
    [1,0,0,0,0, 0,0,0,1,1, 0,0,0,0,1, 1,0,0,0,0, 0,0,0,1,0, 0,0,0,0,0, 1,0,0,0,0, 0,0,0,0,4],

    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,1,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,4],
    [1,1,0,0,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1],
    [1,0,0,0,0, 0,0,1,0,0, 0,0,0,0,0, 0,0,0,1,1, 0,0,0,0,0, 0,1,1,0,0, 0,0,0,0,0, 0,0,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,3, 0,0,0,0,0, 0,0,1,0,0, 0,0,0,0,1, 0,0,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,3, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,1],

    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,3, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,3, 0,0,0,1,0, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,3, 0,0,1,1,1, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,1],
    [1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,0, 1,0,0,0,1],

    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,1,1, 0,0,0,1,1, 0,0,0,0,0, 0,1,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,1,1, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,1],
    [1,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,1],
    [1,0,0,0,0, 0,1,0,0,0, 0,0,0,0,0, 0,0,0,0,1, 0,0,0,0,0, 0,0,0,0,0, 0,0,1,0,1, 0,0,0,0,1],
    [1,1,1,1,1, 1,1,1,1,0, 0,1,1,1,1, 1,0,0,0,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1],
  ]
  
  constructor: ->
    Crafty.init Game.VIEWPORT_WIDTH, Game.VIEWPORT_HEIGHT
    Crafty.scene 'main', @mainScene
      
  start: ->
    Crafty.scene 'main'
  
  mainScene: =>
    Crafty.background("#B7E6ED");
    @generateWorld()
    @createPlayer()
    @resetLevel()
    Crafty.bind 'EnterFrame', @updateTime
    
  generateWorld: ->
    for column in [0...Game.TILES_X]
      for row in [0...Game.TILES_Y]
        
        switch Game.LEVEL[row][column]
          
          # insert floor and ceiling blocks
          when 1 then @insertBoxAt('solid', column, row)
          
          # insert slowdown blocks
          when 2 then @insertBoxAt('deadly', column, row)
          
          # insert half-time blocks
          when 3 then @insertBoxAt('HalfTime', column, row)
          
          # insert goal blocks
          when 4 then @insertBoxAt('Goal', column, row)
          
          
    return
  
  insertBoxAt: (type, column, row, attributes={}) ->
    box = Crafty.e 'Box, ' + type
    box.Box Game.TILE_SIZE, Game.TILE_SIZE
    box.attr x: @xForColumn(column), y: @yForRow(row), z: 1
    
  createPlayer: ->
    @player = Crafty.e 'Player'
    @player.Box Game.TILE_SIZE, Game.TILE_SIZE    
    @player.bind 'killed', @resetLevel
    @player.bind 'win', @playerWin
    @player.bind 'halftime', @showHalftime

  resetPlayer: ->
    @player.reset()
    @player.attr x: @xForColumn(2), y: @yForRow(Game.TILES_Y - 2) , z: 2

  showHalftime: =>
    if @bestHalftime
      difference = @currentTime - @bestHalftime
      @setHalftime(difference)
    
      if difference > 0
        $('.half-time').addClass('behind')
        
      if @currentTime < @bestHalftime
        @bestHalftime = @currentTime
    else
      @bestHalftime = @currentTime

  setHalftime: (time) ->
    $('.half-time').html(time / 1000 + ' seconds')

  playerWin: =>
    
    Crafty.pause()
    
    console.log(@currentTime, @bestTime)
    
    if not @bestTime? or @currentTime < @bestTime
      @bestTime = @currentTime
      $('.best-time').html(@bestTime / 1000 + ' seconds')
      
      $('.message.new-best')
      .fadeIn('slow')
      .delay('2000')
      .fadeOut 'slow', =>
        @resetLevel()
        
    else
      $('.message.not-best')
      .fadeIn('fast')
      .delay('2000')
      .fadeOut 'fast', =>
        @resetLevel()
        

  resetViewport: ->
    Crafty.viewport.x = 0

  updateTime: =>
    if @startTime
      @currentTime = new Date().getTime() - @startTime
      $('.current-time').html(@currentTime / 1000 + ' seconds')

  resetTime: ->
    @startTime = new Date().getTime()
    @setHalftime(0)
    $('.half-time').removeClass('behind')

  resetLevel: =>
    @resetPlayer()
    @resetViewport()
    @resetTime()
    
    if Crafty._paused then Crafty.pause() # un-pause

  midColumn: ->
    Math.floor Game.TILES_X / 2
    
  midRow: ->
    Math.floor Game.TILES_Y / 2
    
  xForColumn: (column) ->
    Game.TILE_SIZE * column
    
  yForRow: (row) ->
    Game.TILE_SIZE * row

# INITIALIZE
$(document).ready ->
  game = new Game()
  game.start()