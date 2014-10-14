package maryfisher.core {
	import maryfisher.framework.command.asset.IAssetCallback;
	import maryfisher.framework.command.asset.LoadAssetCommand;
	import maryfisher.framework.command.CommandSequencer;
	import maryfisher.framework.event.IChild;
	import maryfisher.framework.event.IParent;
	import maryfisher.framework.model.AbstractModelProxy;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AbstractState extends AbstractModelProxy implements IAssetCallback, IChild {
		
		protected var _parent:IParent;
		protected var _isActive:Boolean;
		protected var _mainView:IViewComponent;
		private var _update:DeluxeSignal;
		private var _commandSequencer:CommandSequencer;
		
		public function AbstractState() {
			super();
			
			_update = new DeluxeSignal(this);
		}
		
		public function init():void {
			_commandSequencer = new CommandSequencer();
			addAssetsFinishedCallback(onAssetsFinished)
		}
		
		protected function addAssetsFinishedCallback(callback:Function):void {
			
			_commandSequencer.finishedExecutionSignal.addOnce(callback);
		}
		
		protected function onAssetsFinished():void {
			
		}
		
		protected function addLoadAsset(assetId:String):void {
			_commandSequencer.addCommand(new LoadAssetCommand(assetId, this, "", false, null, false));
		}
		
		protected function startLoading():void {
			_commandSequencer.execute();
		}
		
		final public function enterState():void {
			_isActive = true;
			if(_mainView){
				activate();
			}
		}
		
		protected function activate():void {
			_mainView.addView();
		}
		
		protected function deactivate():void {
			_mainView.removeView();
		}
		
		final public function exitState():void {
			_isActive = false;
			if(_mainView){
				deactivate();
			}
			
		}
		
		/* INTERFACE maryfisher.framework.command.asset.IAssetCallback */
		
		public function assetFinished(cmd:LoadAssetCommand):void {
			
		}
		
		public function pause():void {
			
		}
		
		public function resume():void {
			
		}
		
		public function get stateId():String {
			throw new Error("[AbstractState] stateId: Overwrite this method!");
			return null;
		}
		
		/* INTERFACE maryfisher.framework.event.IChild */
		
		public function get parent():IParent {
			return _parent;
		}
		
		public function set parent(value:IParent):void {
			_parent = value;
		}
		
		protected function set mainView(value:IViewComponent):void {
			_mainView = value;
			if (_isActive) activate();
		}
		
		protected function dispatch(e:GenericEvent):void {
			_update.dispatch(e);
		}
		
		
	}

}