Crafty.c "Player", {
    
    speed: 0
    maxSpeed: 5
    agility: 1
    haltimeOver: false
    roundOver: false
    
    init: ->
      @requires "Box, AdvancedGravity, Keyboard, Health, Collision"
      
      @color '#000000'
      @gravity 'solid'
      
      @bind 'KeyDown', @onKeyDown
      @bind 'EnterFrame', @updatePosition
      @bind 'Moved', @checkCollions
      
      @onHit 'HalfTime', =>
        unless @halftimeOver
          @trigger 'halftime'
          @halftimeOver = true
      
      @onHit 'Goal', ->
         unless @roundOver
            @trigger 'win'
            @roundOver = true
      
    reset: ->
      @speed = 0
      @maxSpeed = 5
      @agility = 1
      @halftimeOver = false
      @roundOver = false
    
    onKeyDown: (event) ->
      switch event.key
        when Crafty.keys.UP_ARROW then @setGravityDirection(-1)
        when Crafty.keys.DOWN_ARROW then @setGravityDirection(1)
        
    checkForSpeedChanges: ->
      if @isDown(Crafty.keys.LEFT_ARROW)
        if @speed > -@maxSpeed then @speed -= @agility
            
      if @isDown(Crafty.keys.RIGHT_ARROW)
        if @speed < @maxSpeed then @speed += @agility
            
    checkCollisions: (movedFrom) ->
      if @hit('solid')
        @attr movedFrom
        @speed = 0
        
    updatePosition: ->
      @checkForSpeedChanges()
      beforeX = @x
      beforeY = @y
      
      @x += @speed
      
      @checkCollisions x: beforeX, y: beforeY
      
      if @y < 0 or (@y + @h > Crafty.viewport.height)
        @kill()

  }