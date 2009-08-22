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
  import flash.events.Event;
  import flash.geom.Point;

  /**
  * WispCompleteEvent
  * An event declaring the completion of a whisp and its final location.
  *
  * @author Paul Coyle &lt;paul@paulcoyle.com&gt;
  */
  public class WispCompleteEvent extends Event {
    private var _location:Point;
    
    public static const COMPLETE:String = 'complete';
    
    public function WispCompleteEvent(type:String, location:Point) {
      super(type);
      _location = location;
    }
    
    // PUBLIC
    /**
    * Gets and sets the location property.
    */
    public function get location():Point { return _location }
    public function set location(value:Point):void { _location = value }
  }
}