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
  /**
  * WispConfig
  * Contains the settings for a whisp.
  *
  * @author Paul Coyle &lt;paul@paulcoyle.com&gt;
  */
  public class WispConfig {
    // Existence
    public var lifespan:int = 15;
    public var decay_speed:uint = 2;
    public var iterations:uint = 3;
    
    // Display
    public var segments:uint = 25;
    public var colour:uint = 0xffffff;
    public var max_width:Number = 2;
    
    // Speed/Acceleration
    public var initial_speed:Number = 0;
    public var acceleration:Number = 1;
    public var acceleration_mod:int = 1;
    public var max_speed:Number = 25;
    
    // Turning Speed/Acceleration
    public var initial_angle:Number = 0;
    public var initial_turn_speed:Number = 0;
    public var initial_turn_direction:int = 1;
    public var turn_acceleration:Number = 0.015;
    public var max_turn_speed:Number = 0.25;
  }
}