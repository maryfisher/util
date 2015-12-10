package maryfisher.view.starling {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import maryfisher.framework.view.IDisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseStarlingSprite extends Sprite implements IDisplayObject {
		
		private var _dispatcher:EventDispatcher;
		
		public function BaseStarlingSprite() {
			super();
			_dispatcher = new EventDispatcher();
			
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function hasListener(type:String):Boolean {
			return _dispatcher.hasEventListener(type);
		}
		
		public function dispatch(e:Event):void {
			_dispatcher.dispatchEvent(e);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
	}

}