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
  * History
  * A history is just an array which only keeps a set number of elements and
  * discards the oldest element when adding a new one past its limit.
  *
  * @author Paul Coyle &lt;paul@paulcoyle.com&gt;
  */
  public class History {
    private var _size:uint;
    private var _elements:Array;
    
    public function History(size:uint) {
      _size = size;
      _elements = new Array();
    }
    
    // PUBLIC
    /**
    * Gets the a copy of the elements array.
    */
    public function get elements():Array { return _elements.slice() }
    
    /**
    * Gets and sets the size property.  If the new size is smaller than it was
    * previously, the oldest elements are removed.
    */
    public function get size():uint { return _size }
    public function set size(value:uint):void {
      if (value != _size) {
        if ((value < _size) && (value < _elements.length)) {
          _elements.splice(0, (_elements.length - value));
        }
        _size = value;
      }
    }
    
    /**
    * Gets the last value.
    */
    public function get last():* {
      return _elements[int(_elements.length - 1)]
    }
    
    /**
    * Clears out the elements.
    */
    public function clear():void {
      _elements = new Array();
    }
    
    /**
    * Adds an element.
    */
    public function add(value:*):void {
      if (_elements.push(value) > _size) _elements.shift();
    }
  }
}