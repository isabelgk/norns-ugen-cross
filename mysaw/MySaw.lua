engine.name = "MySaw"

mysaw = include("mysaw/lib/mysaw_engine")
s = require "sequins"


function init()
  mysaw.add_params()
  mults = s{1, 2.25, s{0.25, 1.5, 3.5, 2, 3, 0.75}}
  playing = false
  sequence = clock.run(
    function()
      while true do
        clock.sync(1/3)
        if playing then
          mysaw.trig(200 * mults() * math.random(2))
        end
      end
    end
  )
end

function key(n, z)
  if n == 3 and z == 1 then
    playing = not playing
    mults:reset()
    redraw()
  end
end

function redraw()
  screen.clear()
  screen.move(64, 32)
  screen.text(playing and "K3: turn off" or "K3: turn on")
  screen.update()
end