package maryfisher.view.comp {
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import maryfisher.event.DataDetailEvent;
	import maryfisher.view.ui.component.BaseSprite;
	import maryfisher.framework.view.IDisplayObject;
	import maryfisher.view.ui.component.BaseDropDownMenu;
	import maryfisher.view.ui.component.FormatText;
	import maryfisher.view.ui.interfaces.IButton;
	import maryfisher.view.ui.interfaces.ICheckBox;
	import maryfisher.view.ui.interfaces.ITooltip;
	import maryfisher.view.ui.interfaces.ITooltipButton;
	import maryfisher.view.ui.mediator.ListMediator;
	import maryfisher.view.ui.text.InputText;
	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseDataDetailComponent extends BaseSprite implements IBubbleEventHandler {
		
		private var _components:Dictionary;
		private var _componentIds:Dictionary;
		private var _compList:ListMediator;
		private var _inputClass:Class;
		
		public function BaseDataDetailComponent() {
			
			_compList = new ListMediator();
			_compList.hasVariableDims = true;
			_compList.setColumns(1);
			_compList.setDistances(10, 10);
			_components = new Dictionary();
			_componentIds = new Dictionary();
		}
		
		public function reset():void {
			_components = new Dictionary();
			_componentIds = new Dictionary();
			removeChildren();
			_compList.reset();
		}
		
		public function addInputText(compId:String, text:String):void {
			var comp:InputText = getInput(compId);
			comp.label = text;
			addComp(compId, comp);
		}
		
		public function addCheckBox(compId:String, value:Boolean):void {
			var cb:ICheckBox = getCheckBox(compId);
			addComp(compId, cb);
		}
		
		/**
		 *
		 * @param compId
		 * @param content Vector.<*>
		 * @param itemId
		 * @param labelId
		 */
		public function addDropDown(compId:String, content:*, itemId:String, labelId:String, tooltipId:String = null):void {
			var comp:BaseDropDownMenu = getDropDownMenu(compId);
			fillDropDown(comp, content, itemId, labelId, tooltipId);
			addComp(compId, comp);
		}
		
		public function alterDropDown(compId:String, content:*, itemId:String, labelId:String, tooltipId:String = null):void {
			var comp:BaseDropDownMenu = _components[compId];
			comp.reset();
			fillDropDown(comp, content, itemId, labelId, tooltipId);
		}
		
		public function addToDropDown(compId:String, id:String, label:String, tooltip:String = null):void {
			var comp:BaseDropDownMenu = _components[compId] as BaseDropDownMenu;
			var b:ITooltipButton = comp.addListElement(id, label) as ITooltipButton;
			if (tooltip) {
				var t:ITooltip = getTooltip(b, tooltip);
				//t.htmlText = tooltip;
				b.attachTooltip(t);
			}
		}
		
		public function getDropDownIndex(compId:String):int {
			var comp:BaseDropDownMenu = _components[compId];
			return comp.selectedIndex;
		}
		
		public function getInputText(compId:String):String {
			var comp:InputText = _components[compId];
			return comp.label;
		}
		
		/* INTERFACE org.osflash.signals.events.IBubbleEventHandler */
		public function onEventBubbled(event:IEvent):Boolean {
			var comp:*;
			
			if (event.target is InputText || event.target is ICheckBox || event.target is BaseDropDownMenu) {
				comp = event.target;
			}
			if (!comp)
				return false;
			
			dispatchEvent(new DataDetailEvent(DataDetailEvent.DATA_DETAIL_CHANGED, _componentIds[comp]));
			
			return false;
		}
		
		public function destroy():void {
			reset();
		}
		
		protected function addLabel():FormatText {
			throw new Error("[DataDetailComponent] [addLabel] Please overwrite this method.");
			return null;
		}
		
		protected function getInput(compId:String):InputText {
			throw new Error("[DataDetailComponent] [getInput] Please overwrite this method.");
			return null;
		}
		
		protected function getCheckBox(compId:String):ICheckBox {
			throw new Error("[DataDetailComponent] [getCheckBox] Please overwrite this method.");
			return null;
		}
		
		protected function getDropDownMenu(compId:String):BaseDropDownMenu {
			throw new Error("[DataDetailComponent] [getDropDownMenu] Please overwrite this method.");
			return null;
		}
		
		protected function getTooltip(b:IButton, tooltip:String):ITooltip {
			throw new Error("[DataDetailComponent] [getTooltip] Please overwrite this method.");
			return null;
		}
		
		private function addComp(compId:String, comp:IDisplayObject):void {
			_components[compId] = comp;
			_componentIds[comp] = compId;
			_compList.addListChild(comp);
			
			var compLabel:FormatText = addLabel();
			compLabel.y = comp.y;
			compLabel.text = compId;
			addChild(compLabel);
			var dComp:DisplayObject = comp as DisplayObject;
			dComp.x = compLabel.x + compLabel.width + 10;
			addChild(dComp);
		}
		
		private function fillDropDown(comp:BaseDropDownMenu, content:*, itemId:String, labelId:String, tooltipId:String = null):void {
			var b:ITooltipButton;
			for each (var item:Object in content) {
				if (item.hasOwnProperty("config")) {
					b = comp.addListElement(item.config[itemId], item.config[labelId]) as ITooltipButton;
				} else if (itemId && labelId) {
					b = comp.addListElement(item[itemId], item[labelId]) as ITooltipButton;
				} else {
					b = comp.addListElement(String(item), String(item)) as ITooltipButton;
				}
				if (tooltipId) {
					var t:ITooltip;
					if (item.hasOwnProperty("config")) {
						if (item.config.hasOwnProperty(tooltipId)) {
							t = getTooltip(b, item.config[tooltipId]);
						}
					}else {
						if (item.hasOwnProperty(tooltipId)) {
							t = getTooltip(b, item[tooltipId]);
						}
					}
					b.attachTooltip(t);
				}
			}
			comp.init();
		}
	}

}