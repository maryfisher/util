package maryfisher.data.log {
	
	/**
	 * ...
	 * @author maryfisher
	 */
	public class LogData {
		public var timestamp:String;
		public var content:String;
		
		public function LogData(content:String, timestamp:String) {
			this.timestamp = timestamp;
			this.content = content;
		
		}
		
		public function toString():String {
			return timestamp + " - " + content;
		}
	}

}