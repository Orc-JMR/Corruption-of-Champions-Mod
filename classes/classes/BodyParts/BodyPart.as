/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.SimpleJsonable;

public class BodyPart extends SimpleJsonable{
	include "../../../includes/appearanceDefs.as";

	public function restore(keepColor:Boolean = true):void {
	}
	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		restore(false);
		super.loadFromObject(o, ignoreErrors);
	}
	protected var creature:Creature;
	public function BodyPart(creature:Creature) {
		this.creature       = creature;
	}
}
}
