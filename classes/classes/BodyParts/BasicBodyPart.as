/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

/**
 * Common dyeable & tfable body part superclass.
 */
public class BasicBodyPart extends BodyPart {
	public var modColor:String = "";

	public function get color():String {return modColor == "" ? defaultColor() : modColor;}
	[Deprecated(message="Consider changing modColor field")]
	public function set color(value:String):void { modColor = (value == defaultColor()) ? "" : value}
	public function defaultColor():String {
		return "albino";
	}
	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) this.modColor = "";
	}
	public function BasicBodyPart(creature:Creature, restoreToType:int) {
		super(creature, restoreToType);
		addPublicPrimitives("modColor");
		this.creature = creature;
	}

	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		super.loadFromObject(o, ignoreErrors);
		// Upgrade old saves
		if ("tone" in o && !("color" in o)) {
			//noinspection JSDeprecatedSymbols
			this.color = o.tone;
		}
	}
}
}
