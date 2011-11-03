Crafty.c "AdvancedGravity", {
  _gravity: 0.2,
  _gy: 0,
  _falling: true,
  _anti: null,
  _direction: 1,
  
  init: ->
    @requires("2D, Collision")
    @setGravityDirection(1)
  
  gravity: (component) ->
    if(component) then @_anti = component

    @bind("EnterFrame", @_enterframe)

    return this
  
  setGravityDirection: (@_newDirection) ->
  
  switchGravityDirection: ->
    @setGravityDirection(-@_direction)

  _enterframe: ->
    if @_falling 
      # if falling, move the players Y
      @_gy += @_gravity * 2 * @_direction
      @y += @_gy
    else
      @_gy = 0 # reset change in y

    hit = false
    pos = @pos()

    pos._y += @_direction

    # map.search wants _x and intersect wants x...
    pos.x = pos._x
    pos.y = pos._y
    pos.w = pos._w
    pos.h = pos._h
    
    query = Crafty.map.search(pos)
    
    for i in [0...query.length]
      obj = query[i]
      # check for an intersection directly below the player
      if obj isnt this and obj.has(@_anti) and obj.intersect(pos)
        hit = obj
        break
    
    if hit # stop falling if found
      if @_falling
        @y = hit._y - @_direction * @_h # move object

        @_falling = false
        if @_up then @_up = false
        @trigger("hit")
        
      else
        if @_newDirection isnt @_direction
          @_direction = @_newDirection
    else
      @_falling = true; # keep falling otherwise

  antigravity: ->
    @unbind "EnterFrame", @_enterframe
}