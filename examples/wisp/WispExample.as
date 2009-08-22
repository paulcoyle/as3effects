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
package {
  import paulcoyle.effects.wisp.*;
  
  import flash.display.*;
  import flash.events.*;
  import flash.geom.Point;

  /**
  * WispExample
  * Example use of the whisp effect.
  *
  * @author Paul Coyle &lt;paul@paulcoyle.com&gt;
  */
  public class WispExample extends Sprite {
    private var _whisp:Wisp;
    private var _whisp_layer:Sprite;
    
    private var _colour_angle:Number = 0;
    
    public function WispExample() {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;
      
      _whisp_layer = new Sprite();
      addChild(_whisp_layer);
      
      stage.addEventListener(MouseEvent.CLICK, on_stage_click, false, 0, true);
      stage.addEventListener(Event.ENTER_FRAME, on_enter_frame, false, 0, true);
    }
    
    // PRIVATE
    /**
    * Adds whisps on click.
    */
    private function on_stage_click(event:MouseEvent):void {
      stage.removeEventListener(Event.ENTER_FRAME, on_enter_frame);
      create_whisp(event.stageX, event.stageY);
    }
    
    /**
    * Creates a new whisp at the supplied coordinates.
    */
    private function create_whisp(x:Number = 0, y:Number = 0):void {
      var config:WispConfig = new WispConfig();
          config.colour = hsb2rgb(_colour_angle, 1, 1);
          config.max_width = (Math.random() * 6) + 0.5; 
          config.initial_angle =  Math.PI * 2 * Math.random();
          config.initial_turn_speed = Math.random() * 0.2;
      
      var whisp:Wisp = new Wisp(new Point(x, y), config);
          whisp.addEventListener(WispCompleteEvent.COMPLETE, on_whisp_complete,
                                 false, 0, true);
      _whisp_layer.addChild(whisp);
      
      _colour_angle = (_colour_angle + 5) % 360;
    }
    
    /**
    * Handles a whisp completing its animation.  Removes it.
    */
    private function on_whisp_complete(event:WispCompleteEvent):void {
      var whisp:Wisp = event.target as Wisp;
      
      graphics.beginFill(whisp.config.colour, 0.2);
      graphics.drawCircle(event.location.x, event.location.y,
        whisp.config.max_width * 2);
      
      _whisp_layer.removeChild(whisp);
    }
    
    /**
    * Randomly creates whisps from the centre of the stage.
    */
    private function on_enter_frame(event:Event):void {
      if (Math.random() > 0.7) {
        create_whisp(stage.stageWidth / 2, stage.stageHeight / 2);
      }
    }
    
    /*
    * Converts from HSB to RGB as a uint.
    */
    private function hsb2rgb(hue:Number, sat:Number, black:Number):uint {
		  if (black == 0) return 0;
		  
		  hue = (hue % 360) / 60;
      var i:Number = Math.floor(hue);
      var f:Number = hue - i;
      var p:Number = black * (1 - sat);
      var q:Number = black * (1 - (sat * f));
      var t:Number = black * (1 - (sat * (1 - f)));
      
      var red:Number, grn:Number, blu:Number
      if (i == 0) { red=black; grn=t; blu=p; }
      else if (i == 1) { red=q; grn=black; blu=p; }
      else if (i == 2) { red=p; grn=black; blu=t; }
      else if (i == 3) { red=p; grn=q; blu=black; }
      else if (i == 4) { red=t; grn=p; blu=black; }
      else if (i == 5) { red=black; grn=p; blu=q; }
    
      return Math.floor(red * 255) << 16 | Math.floor(grn * 255) << 8 | Math.floor(blu * 255);
    }
  }
}