/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

/**
 * Common dyeable body part superclass.
 *
 *
 */
public class BodyPart {
	include "../../../includes/appearanceDefs.as";

	protected var _type:int;
	protected var _restoreToType:int;
	protected var modColor:String = "";

	public function get type():int {return _type;}
	public function set type(value:int):void {_type = value;}

	public function get color():String {return modColor == "" ? defaultColor() : modColor;}
	public function set color(value:String):void {modColor = value;}

	public function defaultColor():String {
		return creature.skin.color;
	}

	public function restore(keepTone:Boolean = true):void {
		if (!keepTone) this.modColor = "";
		this.type = _restoreToType;
	}

	protected var creature:Creature;

	public function BodyPart(creature:Creature, restoreToType:int) {
		this.creature       = creature;
		this._restoreToType = restoreToType;
	}


}
}
