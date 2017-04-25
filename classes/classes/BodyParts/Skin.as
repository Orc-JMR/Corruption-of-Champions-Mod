package classes.BodyParts {
import classes.Creature;
import classes.internals.SimpleJsonable;
import classes.internals.Utils;

/**
 * Container class for the players skin
 * @since December 27, 2016
 * @author Stadler76
 */
public class Skin extends BodyPart {
	include "../../../includes/appearanceDefs.as";

	public var desc:String     = "skin";
	public var furColor:String = "no";
	public var tone:String = "albino";
	public var adj:String = "";
	public var type:int = SKIN_TYPE_PLAIN;

	public function Skin(creature:Creature) {
		super(creature);
	}

	public function skinFurScales():String {
		var skinzilla:String = "";
		//Adjectives first!
		if (adj != "")
			skinzilla += adj + ", ";

		//Fur handled a little differently since it uses haircolor
		skinzilla += hasFur() ? furColor : tone;

		return skinzilla + " " + desc;
	}

	public function description(noAdj:Boolean = false, noTone:Boolean = false):String {
		var skinzilla:String = "";

		//Adjectives first!
		if (!noAdj && adj != "" && !noTone && tone != "rough gray")
			skinzilla += adj + ", ";
		if (!noTone)
			skinzilla += tone + " ";

		//Fur handled a little differently since it uses haircolor
		skinzilla += hasFur() ? "skin" : desc;

		return skinzilla;
	}

	public function hasFur():Boolean {
		return type == SKIN_TYPE_FUR;
	}

	override public function restore(keepTone:Boolean = true):void {
		super.restore(keepTone);
		if (!keepTone) tone = "albino";
		desc     = "skin";
		furColor = "no";
		adj = "";
	}

	public function setProps(p:Object):void {
		Utils.copyObjectEx(this,p,myPublicPrimitives());
	}

	public function setAllProps(p:Object, keepTone:Boolean = true):void {
		restore(keepTone);
		setProps(p);
	}

	override protected function myPublicPrimitives():Array {
		return super.myPublicPrimitives().concat("type","adj","tone","desc","furColor");
	}
}
}
