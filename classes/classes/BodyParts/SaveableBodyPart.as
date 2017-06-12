/**
 * Created by aimozg on 01.05.2017.
 */
package classes.BodyParts {
import classes.internals.SimpleJsonable;

public class SaveableBodyPart extends SimpleJsonable {
	private var keyInSaveData:String;
	public function SaveableBodyPart(keyInSaveData:String, publicPrimitives:Array) {
		super();
		addPublicPrimitives(publicPrimitives);
		this.keyInSaveData = keyInSaveData;
	}
	public function restore(keepColor:Boolean = true):void {
	}
	public function loadFromSaveData(savedata:Object):void {
		restore(false);
		var o:Object = objectOr(savedata[keyInSaveData], null);
		try {
			if (o) {
				loadFromObject(o, false);
				return;
			}
		} catch (e:*){
			trace(e);
		}
		loadFromOldSave(savedata);
	}
	protected function loadFromOldSave(savedata:Object):void {
	}
	protected function saveToOldSave(savedata:Object):void {
	}
	public function saveToSaveData(savedata:Object):void {
		savedata[keyInSaveData] = saveToObject();
		saveToOldSave(savedata);
	}
}
}
