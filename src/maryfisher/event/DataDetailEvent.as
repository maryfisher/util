package maryfisher.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author maryfisher
	 */
	public class DataDetailEvent extends Event {
		
		static public const DATA_DETAIL_COMMIT:String = "DataDetailEvent/dataDetailCommit";
		static public const DATA_DETAIL_DISCARD:String = "DataDetailEvent/dataDetailDiscard";
		static public const DATA_DETAIL_CHANGED:String = "DataDetailEvent/dataDetailChanged";
		
		public var compId:String;
		
		public function DataDetailEvent(type:String, compId:String = null) {
			super(type);
			this.compId = compId;
			
		}
	
	}

}