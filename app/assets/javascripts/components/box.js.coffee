Crafty.c "Box", {
    
    init: ->
      this.requires "2D, DOM, Color"
      @w = 16
      @h = 16
      @color('#999')
      
    Box: (@w, @h, @color) ->

  }