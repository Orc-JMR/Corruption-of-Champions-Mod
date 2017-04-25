package classes.BodyParts {
import classes.Creature;

/**
 * Container class for the players skin
 * @since December 27, 2016
 * @author Stadler76
 */
public class Skin extends SkinPart {
	include "../../../includes/appearanceDefs.as";

	public var desc:String     = "skin";
	public var furColor:String = "no";

	public function Skin(creature:Creature) {
		super(creature);
		tone = "albino";
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

	override public function defaultColor():String {
		return modColor;
	}
	override public function defaultAdj():String {
		return modAdj;
	}

	public function hasFur():Boolean {
		return type == SKIN_TYPE_FUR;
	}

	override public function restore(keepTone:Boolean = true):void {
		desc     = "skin";
		furColor = "no";
	}

	public function setProps(p:Object):void {
		if (p.hasOwnProperty('type')) type = p.type;
		if (p.hasOwnProperty('tone')) tone = p.tone;
		if (p.hasOwnProperty('desc')) desc = p.desc;
		if (p.hasOwnProperty('adj')) adj = p.adj;
		if (p.hasOwnProperty('furColor')) furColor = p.furColor;
	}

	public function setAllProps(p:Object, keepTone:Boolean = true):void {
		restore(keepTone);
		setProps(p);
	}
}
}
