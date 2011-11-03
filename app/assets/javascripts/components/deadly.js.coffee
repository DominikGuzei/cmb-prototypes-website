Crafty.c "deadly", {
    
    init: ->
      @requires 'Collision, Color'
      @onHit('Health', @killVictim)
      @color '#FF3333'
    
    killVictim: (victim) ->
      victim[0].obj.kill()
    
  }