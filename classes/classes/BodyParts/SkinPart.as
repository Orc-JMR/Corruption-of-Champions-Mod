/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class SkinPart extends BasicBodyPart {
	public var modAdj:String = "";
	public var modDesc:String = "";
	public function get adj():String {return modAdj == "" ? defaultAdj() : modAdj;}
	[Deprecated(message="Consider changing modAdj field")]
	public function set adj(value:String) {modAdj = (value == "") ? defaultAdj() : value;}
	public function get desc():String {return modDesc == "" ? defaultAdj() : modDesc;}
	[Deprecated(message="Consider changing modDesc field")]
	public function set desc(value:String) {modDesc = (value == "") ? defaultDesc() : value;}

	override public function defaultColor():String {
		return creature.skin.tone;
	}
	public function defaultAdj():String {
		return creature.skin.adj;
	}
	public function defaultDesc():String {
		return creature.skin.desc;
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		modAdj = "";
	}
	public function SkinPart(creature:Creature) {
		super(creature, SKIN_TYPE_PLAIN);
		addPublicPrimitives("modAdj");
	}

	override public function saveToObject():Object {
		var o:Object = super.saveToObject();
		o.modAdj = modAdj;
		return o;
	}
	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		super.loadFromObject(o, ignoreErrors);
	}
}
}
