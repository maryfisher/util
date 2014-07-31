package maryfisher.util.command {
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.events.ParserEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.AssetLoaderContext;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import maryfisher.framework.command.loader.LoaderCommand;
	import maryfisher.framework.data.LoaderData;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Away3DLoaderCommand extends LoaderCommand {
		
		private var _loader3D:Loader3D;
		private var _mesh:Mesh;
		
		public function Away3DLoaderCommand(id:String, fileId:String, callback:Function, priority:int = 0, executeInstantly:Boolean = true) {
			_finishedLoading = new Signal(Away3DLoaderCommand);
			//_finishedLoading.add(_callback.imageLoadingFinished);
			_finishedLoading.add(callback);
			super(id, fileId, priority, executeInstantly);
		}
		
		override public function loadAsset(loaderData:LoaderData):void {
			super.loadAsset(loaderData);
			
			var assetLoaderContext:AssetLoaderContext = new AssetLoaderContext(false);
			_loader3D = new Loader3D(false);
			_loader3D.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false, 0, true);
			//_loader3D.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress, false, 0, true);
			_loader3D.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError, false, 0, true);
			_loader3D.addEventListener(ParserEvent.PARSE_ERROR, onParserError, false, 0, true);
			_loader3D.load(new URLRequest(_loaderData.path + _fileId), assetLoaderContext);
			
		}
		
		private function onLoadError(e:LoaderEvent):void {
			
		}
		
		private function onParserError(e:ParserEvent):void {
			
		}
		
		private function onLoadingProgress(e:ProgressEvent):void {
			setProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		private function onAssetLoaded(e:AssetEvent):void {
			if (e.asset.assetType == AssetType.MESH) {
				_loader3D.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetLoaded, false);
				//_loader3D.removeEventListener(ProgressEvent.PROGRESS, onLoadingProgress, false);
				_loader3D.removeEventListener(LoaderEvent.LOAD_ERROR, onLoadError, false);
				_loader3D.removeEventListener(ParserEvent.PARSE_ERROR, onParserError, false);
				
				_mesh = e.asset as Mesh;
				_loader3D.dispose();
				
				setFinished();
			}
		}
		
		//public function get mesh():Mesh {
			//return _mesh;
		//}
		
		override public function get asset():Object {
			return _mesh;
		}
		
		override public function set asset(value:Object):void {
			/** TODO
			 * ??
			 */
			if(_loaderData.reuse){
				_mesh = new Mesh((value as Mesh).geometry);
			}else {
				_mesh = new Mesh((value as Mesh).geometry.clone());
			}
		}
		
		override public function get cacheAsset():Object {
			return _mesh;
		}
	}

}