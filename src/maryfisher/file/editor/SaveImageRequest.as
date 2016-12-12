package maryfisher.file.editor {
	import com.adobe.images.JPGEncoder;
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import maryfisher.framework.command.net.FileRequest;
	import maryfisher.framework.data.NetData;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class SaveImageRequest extends FileRequest{
		
		public function SaveImageRequest() {
			
		}
		
		override public function execute(data:Object, netData:NetData, requestSpecs:String):void {
			super.execute(data, netData, requestSpecs);
			
			var bitmap : Bitmap = new Bitmap(bitmapData);
			var jpg:JPGEncoder = new JPGEncoder();
			var ba:ByteArray = jpg.encode(bitmapData);
		}
	}

}