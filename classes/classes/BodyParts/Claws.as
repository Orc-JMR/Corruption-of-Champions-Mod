/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Claws extends BodyPart{
	public var tone:String = "";
	public function Claws(creature:Creature) {
		super(creature);
		addPublicPrimitives("tone");
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		tone = "";
	}
	override public function describe(options:Object):String {
		var toneText:String = tone == "" ? " " : (", " + tone + " ");
		switch (type) {
			case CLAW_TYPE_NORMAL: return "fingernails";
			case CLAW_TYPE_LIZARD: return "short curved" + toneText + "claws";
			case CLAW_TYPE_DRAGON: return "powerful, thick curved" + toneText + "claws";
				// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernails";
	}
}
}
