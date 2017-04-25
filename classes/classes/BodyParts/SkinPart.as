/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class SkinPart extends BasicBodyPart {
	public var modAdj:String = "";
	public var modColor:String = "";

	public function get color():String {return modColor == "" ? defaultColor() : modColor;}
	public function get adj():String {return modAdj == "" ? defaultAdj() : modAdj;}

	public function defaultColor():String {
		return creature.skin.tone;
	}
	public function defaultAdj():String {
		return creature.skin.adj;
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) this.modColor = "";
		modAdj = "";
	}
	public function SkinPart(creature:Creature) {
		super(creature, SKIN_TYPE_PLAIN);
	}

	override protected function myPublicPrimitives():Array {
		return super.myPublicPrimitives().concat("modAdj","modColor");
	}
	override public function saveToObject():Object {
		var o:Object = super.saveToObject();
		o.modAdj = modAdj;
		return o;
	}
	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		super.loadFromObject(o, ignoreErrors);
		// Upgrade old saves
		if ("tone" in o && !("color" in o)) this.modColor = o.tone;
	}
}
}
