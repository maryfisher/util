package maryfisher.data.log {
	import maryfisher.framework.model.BaseModelUpdate;
	import maryfisher.poetry.ch.data.BaseModel;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface ILogUpdatesProxy extends ILogProxy {
		function onLogsSaved(update:BaseModelUpdate):void;
	}
	
}