/**
* Copyright (c) 2008-2009 Paul Coyle
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
package paulcoyle.effects.wisp {
  import flash.display.Shape;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.geom.Point;
  
  /**
  * Wisp
  * The whisp!
  *
  * @author Paul Coyle &lt;paul@paulcoyle.com&gt;
  */
  public class Wisp extends Shape {
    private var _path_history:History;
    private var _config:WispConfig;
    
    private var _life:int = -1;
    private var _angle:Number = 0;
    private var _speed:Number = 0;
    private var _turn_speed:Number = 0;
    private var _turn_direction:int = 1;
    
    public function Wisp(origin:Point, config:WispConfig = null) {
      _config = (config == null) ? new WispConfig() : config;
      
      _life = _config.lifespan;
      _angle = _config.initial_angle;
      _speed = _config.initial_speed;
      _turn_speed = _config.initial_turn_speed;
      _turn_direction = _config.initial_turn_direction;
      
      _path_history = new History(_config.segments);
      _path_history.add(new WidePoint(origin.x, origin.y, 0, _angle));
      
      // Randomize the initial turning direction
      // TODO: Potentially place this in the config as an option
      if (Math.random() >= 0.5) _turn_direction *= -1;
      
      addEventListener(Event.ENTER_FRAME, on_enter_frame, false, 0, true);
    }
    
    // PUBLIC
    /**
    * Gets the configuration object for this whisp.
    */
    public function get config():WispConfig { return _config }
    
    /**
    * Destroys and cleans up the whisp and finally dispatches an event declaring
    * where the whisp's last segment was located.
    */
    public function destroy():void {
      removeEventListener(Event.ENTER_FRAME, on_enter_frame);
      
      var final_point:WidePoint = _path_history.last;
      
      dispatchEvent(
        new WispCompleteEvent(
          WispCompleteEvent.COMPLETE,
          new Point(final_point.x, final_point.y)
        )
      );
      
      _path_history.clear();
      _path_history = null;
      
      _config = null;
      
      graphics.clear();
    }
    
    // PRIVATE
    /**
    * Runs a number of iterations of the whisp's movement steps.  Checks for
    * the end of the whisp's life.
    * 
    * TODO: Don't change values on the config object (acceleration_mod).
    */
    private function on_enter_frame(event:Event):void {
      var i:uint;
      while (i++ < _config.iterations) step();
      
      draw_path();
      
      if (_life > -1) {
        if (_life == 0) {
          _config.acceleration_mod = -1;
          _path_history.size -= _config.decay_speed;
          if (_path_history.size <= _config.decay_speed) destroy();
        }
        else _life -= 1;
      }
    }
    
    /**
    * Steps the whisp.
    */
    private function step():void {
      // Adjust the speed according to the acceleration and the acceleration
      // modifier (positive/negative) but obviously do not go below 0
      _speed = Math.max(
        Math.min(
          _config.max_speed,
          _speed + _config.acceleration * _config.acceleration_mod
        ), 0);
      
      // Adjust the turning speed
      _turn_speed += _config.turn_acceleration * _turn_direction;
      _angle += _turn_speed;
      
      // If the turn speed is above the maximum OR 50% of the time randomly
      // reverse the turning direction
      if ((Math.random() < 0.05) || (Math.abs(_turn_speed) > _config.max_turn_speed))
        _turn_direction *= -1;
      
      // Add a WidePoint to the history
      var last_point:WidePoint = (_path_history.last as WidePoint);
      var new_point:WidePoint = new WidePoint(
        last_point.x + Math.cos(_angle) * _speed,
        last_point.y + Math.sin(_angle) * _speed,
        100, _angle
      );
      _path_history.add(new_point);
    }
    
    /**
    * Clears the drawing layer and draws a path from the history.
    */
    private function draw_path():void {
      graphics.clear();
      
      var points:Array = _path_history.elements;
      var point:WidePoint;
      var last_point:WidePoint;
      var max_p:uint = points.length;
      var p:uint;
      
      // Used for easing method
      var duration:Number = (max_p - 1) / 2;
      var time:Number = duration;
      for (p = 0; p < max_p; p++) {
        point = points[p];
        point.width = ease(
          duration - Math.abs(time), 0, _config.max_width, duration);
        time -= 1;
        
        if (p == 0) {
          last_point = point;
          continue;
        }
        
        graphics.beginFill(_config.colour, 1);
        graphics.moveTo(last_point.left.x, last_point.left.y);
        graphics.lineTo(point.left.x, point.left.y);
        graphics.lineTo(point.right.x, point.right.y);
        graphics.lineTo(last_point.right.x, last_point.right.y);
        last_point = point;
      }
    }
    
    private function ease(t:Number, b:Number, c:Number, d:Number):Number {
  		if ((t/=d/2) < 1) return c/2*t*t + b;
  		return -c/2 * ((--t)*(t-2) - 1) + b;
  	}
  }
}