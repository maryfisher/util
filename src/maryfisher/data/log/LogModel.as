package maryfisher.data.log {
	
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.command.net.NetCommand;
	import maryfisher.framework.model.AbstractModel;
	import maryfisher.framework.model.BaseModelUpdate;
	
	/**
	 * ...
	 * @author maryfisher
	 */
	public class LogModel extends AbstractModel {
		
		static public const ON_LOGS_SAVED:String = "onLogsSaved";
		
		static public const SERVER_SAVE_LOGS:String = "serverSaveLogs";
		
		private var _logDatas:Vector.<LogData>;
		
		public function LogModel() {
			super();
			
			status = DATA_LOADED;
		}
		
		override public function init():void {
			super.init();
			_logDatas = new Vector.<LogData>();
		}
		
		public function addLogData(cl:*, ...logArgs):void {
			var str:String = getClassName(cl) + logArgs.join(", ");
			trace(str);
			_logDatas.push(new LogData(str, new Date().toString()));
		}
		
		public function warn(cl:*, ...logArgs):void {
			var content:String = "ERROR: " + getClassName(cl) + logArgs.join(" ");
			trace(content);
			_logDatas.push(new LogData(content, new Date().toString()));
		}
		
		public function saveLogs(id:String):void {
			new NetCommand(SERVER_SAVE_LOGS, { id: id, logs: _logDatas.join(" \n")}, this)
		}
		
		override public function onRequestReceived(cmd:NetCommand):void {
			if (cmd.id == SERVER_SAVE_LOGS) {
				dispatch(new BaseModelUpdate(ON_LOGS_SAVED));
			}else{
				super.onRequestReceived(cmd);
			}
		}
		
		private function getClassName(cl:*):String {
			var name:String = getQualifiedClassName(cl);
			return "[" + name.substr(name.indexOf("::") + 2) + "] ";
		}
	}
}