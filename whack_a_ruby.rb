

# https://github.com/pauloskaterock

require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack the Ruby!'

    
    @image = Gosu::Image.new('ruby.png')

    @x = 200
    @y = 200

    @width = 300
    @height = 300

    @velocity_x = 5
    @velocity_y = 5

    @visible = 0

    @hammer_image = Gosu::Image.new('hammer.png')

    @hit = 0

    @font = Gosu::Font.new(30)

    @score = 0

    @playing = true

    @start_time = 0
  end

  def update
    @x += @velocity_x
    @y += @velocity_y

    
    @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
    @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0

    @visible -= 1
    @visible = 50 if @visible < -10 && rand < 0.01

    @time_left = (20 - ((Gosu.milliseconds - @start_time) / 1000))

    @playing = false if @time_left < 0
  end

  def draw
    if @visible > 0
      @image.draw(@x - @width / 2, @y - @height / 2, 1)
      c = Gosu::Color::NONE
      draw_quad(@x - 25, @y - 25, c, @x + 25, @y - 25, c, @x + 25, @y + 25, c, @x - 25, @y + 25, c, 2)
    end

    @hammer_image.draw(mouse_x - 25, mouse_y - 25, 3)

    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end

    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)

    @hit = 0

    @font.draw(@score.to_s, 700, 20, 4)

    @font.draw(@time_left.to_s, 20, 20, 4) unless @time_left < 0

    unless @playing
      @font.draw('Game over PH !', 10, 500, 4)
      @font.draw('Press the Space Bar to Play Again', 10, 560, 4)
      @visisble = 20
    end
  end

  def button_down(id)
    if @playing
      if (id == Gosu::MsLeft)
        if Gosu.distance(mouse_x, mouse_y, @x, @y) < 75 && @visible >= 0
          @hit = 1
          @score += 5
        else
          @hit = -1
          @score -= 1
        end
      end
    else
      if (id == Gosu::KbSpace)
        @playing = true
        @visible = -10
        @start_time = Gosu::milliseconds
        @score = 0
      end
    end
  end
end

window = WhackARuby.new
window.show





    
    