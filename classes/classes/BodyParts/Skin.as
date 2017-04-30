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

	public function description(noAdj:Boolean = false, noTone:Boolean = false):String
	{
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
	override public function describe(options:Object):String {
		return description(!!options.noAdj,!!options.noTone);
	}
	/*[INTERMOD:xianxia]
	public function hasChitin():Boolean {
		return [SKIN_TYPE_CHITIN, SKIN_TYPE_PARTIAL_CHITIN].indexOf(type) != -1;
	}
	public function hasBark():Boolean {
		return [SKIN_TYPE_BARK, SKIN_TYPE_PARTIAL_BARK].indexOf(type) != -1;
	}
	public function isPartiallyCovered():Boolean {
		return [
				   SKIN_TYPE_PARTIAL_FUR, SKIN_TYPE_PARTIAL_BARK, SKIN_TYPE_PARTIAL_SCALES, SKIN_TYPE_PARTIAL_CHITIN
			   ].indexOf(type) != -1;
	}
	public function isCovered():Boolean {
		return isPartiallyCovered()
			   || [
					  SKIN_TYPE_FUR, SKIN_TYPE_BARK, SKIN_TYPE_SCALES, SKIN_TYPE_CHITIN
				  ].indexOf(type) != -1;
	}
	public function isFacePartiallyCovered():Boolean {
		return [
				   SKIN_TYPE_SCALES, SKIN_TYPE_PARTIAL_SCALES, SKIN_TYPE_FUR
			   ].indexOf(type) != -1;
	}
	*/
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

	public function hasPlainSkinOnly(allowTatoo:Boolean = true):Boolean {
		return type == SKIN_TYPE_PLAIN;
		/*[INTERMOD:xianxia]
		return type == SKIN_TYPE_PLAIN
			   || allowTatoo && type == SKIN_TYPE_TATTOED;
			   */
	}
	public function hasPlainSkin(allowTatoo:Boolean = true):Boolean {
		return hasPlainSkinOnly();
		/*[INTERMOD:xianxia]
		return hasPlainSkinOnly()
			   || isPartiallyCovered()
			   || allowTatoo && type == SKIN_TYPE_TATTOED;
			   */
	}
	public function hasSmoothSkinType(allowPartiallyCovered:Boolean = true):Boolean {
		return isAny(SKIN_TYPE_PLAIN, SKIN_TYPE_GOO);
		/*[INTERMOD:xianxia]
		return isAny(SKIN_TYPE_TATTOED, SKIN_TYPE_PLAIN, SKIN_TYPE_GOO, SKIN_TYPE_STONE)
			   || allowPartiallyCovered && isPartiallyCovered();
			   */
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
