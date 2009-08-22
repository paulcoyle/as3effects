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
  import flash.geom.Point;
  
  /**
  * WidePoint
  * A wide point is a point that has a width and direction - a little bit like
  * a vector but not really.  It provides two points that represent the
  * extremities of its width with respect to it's angle.
  *
  * @author Paul Coyle &lt;paul@paulcoyle.com&gt;
  */
  public class WidePoint {
    private var _x:Number;
    private var _y:Number;
    private var _width:Number;
    private var _angle:Number;
    
    private var _left:Point;
    private var _right:Point;
    
    private var _cos_cache:Number;
    private var _sin_cache:Number;
    
    public static const HALF_PI:Number = Math.PI / 2;
    
    public function WidePoint(x:Number = 0, y:Number = 0, width:Number = 0,
                    angle:Number = 0) {
      update(x, y, width, angle);
    }
    
    // PUBLIC
    /**
    * Gets and sets the x property.
    */
    public function get x():Number { return _x }
    public function set x(value:Number):void {
      if (value != _x) {
        _x = value;
        update_points();
      }
    }
    
    /**
    * Gets and sets the y property.
    */
    public function get y():Number { return _y }
    public function set y(value:Number):void {
      if (value != _y) {
        _y = value;
        update_points();
      }
    }
    
    /**
    * Gets and sets the width property.
    */
    public function get width():Number { return _width }
    public function set width(value:Number):void {
      if (value != _width) {
        _width = value;
        update_points();
      }
    }
    
    /**
    * Gets and sets the angle property.
    */
    public function get angle():Number { return _angle }
    public function set angle(value:Number):void {
      if (value != _angle) {
        _angle = value;
        update_trig();
        update_points();
      }
    }
    
    /**
    * Sets a number of properties simultaneously which decreases calls to
    * update_points().
    */
    public function update(x:Number = NaN, y:Number = NaN, width:Number = NaN,
                    angle:Number = NaN):void {
      if (!isNaN(x)) _x = x;
      if (!isNaN(y)) _y = y;
      if (!isNaN(width)) _width = width;
      if (!isNaN(angle)) {
        _angle = angle;
        update_trig();
      }
      
      update_points();
    }
    
    /**
    * Gets the left point.
    */
    public function get left():Point { return _left }
    
    /**
    * Gets the right point.
    */
    public function get right():Point { return _right }
    
    /**
    * Clones the object.
    */
    public function clone():WidePoint {
      return new WidePoint(_x, _y, _width, _angle);
    }
    
    /**
    * Returns a string representation of the object.
    */
    public function toString():String {
      return '[WidePoint x="'+x+'" y="'+y+'" width="'+width+'" angle="'+angle+'"]';
    }
    
    // PRIVATE
    /**
    * Re-calculates the trig values used when determining the left and right
    * points.
    */
    private function update_trig():void {
      _cos_cache = Math.cos(_angle - HALF_PI);
      _sin_cache = Math.sin(_angle - HALF_PI);
    }
    
    /**
    * Updates the positions of the left and right points.
    */
    private function update_points():void {
      // If the width is 0 then lets take a shortcut
      if (_width == 0) {
        _left = _right = new Point(x, y);
        return;
      }
      
      var x_offset:Number = _cos_cache * _width;
      var y_offset:Number = _sin_cache * _width;
      
      _left = new Point(x + x_offset, y + y_offset);
      _right = new Point(x - x_offset, y - y_offset);
    }
  }
}