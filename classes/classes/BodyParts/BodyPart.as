/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.SimpleJsonable;

public class BodyPart extends SimpleJsonable {
	include "../../../includes/appearanceDefs.as";

	protected var _type:int;
	protected var _restoreToType:int;
	public function restore(keepColor:Boolean = true):void {
		type = _restoreToType;
	}
	protected var creature:Creature;
	public function BodyPart(creature:Creature, restoreToType:int = 0) {
		addPublicPrimitives("type");
		this.creature       = creature;
		this._restoreToType = restoreToType;
		this.type           = _restoreToType;
	}
	public function get type():int {return _type;}
	public function set type(value:int):void {_type = value;}
	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		restore(false);
		super.loadFromObject(o, ignoreErrors);
		// Upgrade old saves
		if ("type" in o && !("_type" in o)) this.type = o.type;
	}
}
}
