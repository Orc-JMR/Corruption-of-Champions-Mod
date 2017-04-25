/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

/**
 * Common tfable body part superclass.
 */
public class BasicBodyPart extends BodyPart {

	protected var _type:int;
	protected var _restoreToType:int;

	public function get type():int {return _type;}
	public function set type(value:int):void {_type = value;}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		this.type = _restoreToType;
	}
	public function BasicBodyPart(creature:Creature, restoreToType:int) {
		super(creature);
		addPublicPrimitives("type");
		this.creature       = creature;
		this._restoreToType = restoreToType;
	}

	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		super.loadFromObject(o, ignoreErrors);
		// Upgrade old saves
		if ("type" in o && !("_type" in o)) this.type = o.type;
	}
}
}
