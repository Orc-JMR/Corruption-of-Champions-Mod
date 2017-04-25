/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class SkinPart extends BodyPart {
	protected var modAdj:String = "";

	public function get tone():String {return color;}
	public function set tone(value:String):void {color = value;}

	public function get adj():String {return modAdj == "" ? defaultAdj() : modAdj;}
	public function set adj(value:String):void {modAdj = value;}

	public function defaultAdj():String {return creature.skin.adj;}

	override public function restore(keepTone:Boolean = true):void {
		super.restore(keepTone);
		modAdj = "";
	}
	public function SkinPart(creature:Creature) {
		super(creature, SKIN_TYPE_PLAIN);
	}
}
}
