package classes.BodyParts {
import classes.Creature;
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

	public function Skin(creature:Creature) {
		super(creature);
		addPublicPrimitives("tone","adj","desc","furColor");
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


	override public function describe(options:Object):String {
		var skinzilla:String = "";

		//Adjectives first!
		if (!options.noTone) {
			if (adj != "" && !options.noTone && tone != "rough gray")
				skinzilla += adj + ", ";
			skinzilla += tone + " ";
		}

		//Fur handled a little differently since it uses haircolor
		skinzilla += hasFur() ? "skin" : desc;

		return skinzilla;
	}
	public function description(noAdj:Boolean = false, noTone:Boolean = false):String {
		return describe({noAdj:noAdj,noTone:noTone});
	}

	public function hasFur():Boolean {
		return type == SKIN_TYPE_FUR;
	}
	public function hasScales():Boolean {
		return [SKIN_TYPE_LIZARD_SCALES, SKIN_TYPE_DRAGON_SCALES, SKIN_TYPE_FISH_SCALES].indexOf(type) != -1;
	}

	public function hasReptileScales():Boolean {
		return [SKIN_TYPE_LIZARD_SCALES, SKIN_TYPE_DRAGON_SCALES].indexOf(type) != -1;
	}

	public function hasDragonScales():Boolean {
		return type == SKIN_TYPE_DRAGON_SCALES;
	}

	public function hasLizardScales():Boolean {
		return type == SKIN_TYPE_LIZARD_SCALES;
	}

	public function hasNonLizardScales():Boolean {
		return hasScales() && !hasLizardScales();
	}

	public function hasFurOrScales():Boolean {
		return hasFur() || hasScales();
	}

	public function hasGooSkin():Boolean {
		return type == SKIN_TYPE_GOO;
	}

	public function hasPlainSkin():Boolean {
		return type == SKIN_TYPE_PLAIN;
	}
	override public function restore(keepTone:Boolean = true):void {
		super.restore(keepTone);
		if (!keepTone) tone = "albino";
		desc     = "skin";
		furColor = "no";
		adj = "";
	}

	public function setProps(p:Object):void {
		Utils.copyObjectEx(this,p,myPublicPrimitives);
	}

	public function setAllProps(p:Object, keepTone:Boolean = true):void {
		restore(keepTone);
		setProps(p);
	}
}
}
