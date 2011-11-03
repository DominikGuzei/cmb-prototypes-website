Crafty.c "Health", {
    
    init: ->
      @_maxHealth = 100
      @_health = 100
    
    Health: (@_health, @_maxHealth) ->
    
    hurt: (damage) ->
      @_health -= damage
      if @_health <= 0
        @trigger('killed')
        @_health = 0
      
    kill: ->
      @hurt(@_health)

    revive: ->
      @_health = @_maxHealth
      @trigger('revived')
  }