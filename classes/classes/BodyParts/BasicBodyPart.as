/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

/**
 * Common dyeable body part superclass.
 */
public class BasicBodyPart extends BodyPart {

	protected var _type:int;
	protected var _restoreToType:int;
	public var modColor:String = "";

	public function get type():int {return _type;}
	[Deprecated(message="Replace with mod= or restore()")]
	public function set type(value:int):void {_type = value;}

	public function get color():String {return modColor == "" ? defaultColor() : modColor;}

	public function defaultColor():String {
		return creature.skin.tone;
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) this.modColor = "";
	}
	public function BasicBodyPart(creature:Creature, restoreToType:int) {
		super(creature);
		this.creature       = creature;
		this._restoreToType = restoreToType;
	}

	override protected function myPublicPrimitives(): Array {
		return ["type","modColor"];
	}
	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		super.loadFromObject(o, ignoreErrors);
		// Upgrade old saves
		if ("type" in o && !("_type" in o)) this.type = o.type;
	}
}
}
