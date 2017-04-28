/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.Utils;

public class Face extends BodyPart {
	public static const TYPE_HUMAN:int        = 0;
	public static const TYPE_HORSE:int        = 1;
	public static const TYPE_DOG:int          = 2;
	public static const TYPE_COW_MINOTAUR:int = 3;
	public static const TYPE_SHARK_TEETH:int  = 4;
	public static const TYPE_SNAKE_FANGS:int  = 5;
	public static const TYPE_CAT:int          = 6;
	public static const TYPE_LIZARD:int       = 7;
	public static const TYPE_BUNNY:int        = 8;
	public static const TYPE_KANGAROO:int     = 9;
	public static const TYPE_SPIDER_FANGS:int = 10;
	public static const TYPE_FOX:int          = 11;
	public static const TYPE_DRAGON:int       = 12;
	public static const TYPE_RACCOON_MASK:int = 13;
	public static const TYPE_RACCOON:int      = 14;
	public static const TYPE_BUCKTEETH:int    = 15;
	public static const TYPE_MOUSE:int        = 16;
	public static const TYPE_FERRET_MASK:int  = 17;
	public static const TYPE_FERRET:int       = 18;
	public static const TYPE_PIG:int          = 19;
	public static const TYPE_BOAR:int         = 20;
	public static const TYPE_RHINO:int        = 21;
	public static const TYPE_ECHIDNA:int      = 22;
	public static const TYPE_DEER:int         = 23;

	public function Face(creature:Creature) {
		super(creature);
	}

	public function hasMuzzle():Boolean {
		return [
					TYPE_HORSE, TYPE_DOG, TYPE_CAT, TYPE_LIZARD, TYPE_KANGAROO, TYPE_FOX, TYPE_DRAGON, TYPE_RHINO,
					TYPE_ECHIDNA, TYPE_DEER
				].indexOf(type) >= 0;
	}
	public function hasBeard():Boolean {
		return creature.beardLength > 0;
	}
	public function beard():String {
		if (hasBeard()) {
			return "beard";
		} else {
			//CoC_Settings.error("");
			return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL KITTEH IMMEDIATELY.</b>";
		}
	}
	public function nounPhrase():String {
		var stringo:String = "";
		if (type == TYPE_HUMAN) return "face";
		if (hasMuzzle()) {
			if (Utils.trueOnceInN(3)) {
				if (type == TYPE_HORSE) stringo = "long ";
				if (type == TYPE_CAT) stringo = "feline ";
				if (type == TYPE_RHINO) stringo = "rhino ";
				if (type == TYPE_LIZARD
						|| type == TYPE_DRAGON) stringo = "reptilian ";
			}
			return stringo + Utils.randomChoice("muzzle", "snout", "face");
		}
		//3 - cowface
		if (type == TYPE_COW_MINOTAUR) {
			if (Utils.trueOnceInN(4)) stringo = "bovine ";
			return Utils.randomChoice("muzzle", stringo + "face");
		}
		//4 - sharkface-teeth
		if (type == TYPE_SHARK_TEETH) {
			if (Utils.trueOnceInN(4)) stringo = "angular ";
			return stringo + "face";
		}
		if (type == TYPE_PIG || type == TYPE_BOAR) {
			if (Utils.trueOnceInN(4))
				stringo = (type == TYPE_PIG ? "pig" : "boar") + "-like ";
			if (Utils.trueOnceInN(4))
				return stringo + "snout";
			return stringo + "face";
		}
		return "face";
	}
	/**
	 * @param options.fem (default false): Describe femininity level
	 * @param options.a (default false): Add an article a/an/the
	 */
	override public function describe(options:Object):String {
		var femininity:Number = creature.femininity;
		var a:String          = "", an:String = "", the:String = "";
		if (options.a) {
			a   = "a ";
			an  = "an ";
			the = "the ";
		}
		if (!options.fem) {
			return a + nounPhrase();
		} else {
			var faceo:String = "";
			//0-10
			if (femininity < 10) {
				faceo = a + "square chin";
				if (!hasBeard()) faceo += " and chiseled jawline";
				else faceo += ", chiseled jawline, and " + beard();
				return faceo;
			}
			//10+ -20
			else if (femininity < 20) {
				faceo = a + "rugged looking " + nounPhrase() + " ";
				if (hasBeard()) faceo += "and " + beard();
				return faceo + "that's surely handsome";
			}
			//21-28
			else if (femininity < 28)
				return a + "well-defined jawline and a fairly masculine profile";
			//28+-35
			else if (femininity < 35)
				return a + "somewhat masculine, angular jawline";
			//35-45
			else if (femininity < 45)
				return the + "barest hint of masculinity on its features";
			//45-55
			else if (femininity <= 55)
				return an + "androgynous set of features that would look normal on a male or female";
			//55+-65
			else if (femininity <= 65)
				return a + "tiny touch of femininity to it, with gentle curves";
			//65+-72
			else if (femininity <= 72)
				return a + "nice set of cheekbones and lips that have the barest hint of pout";
			//72+-80
			else if (femininity <= 80)
				return a + "beautiful, feminine shapeliness that's sure to draw the attention of males";
			//81-90
			else if (femininity <= 90)
				return a + "gorgeous profile with full lips, a button nose, and noticeable eyelashes";
			//91-100
			else
				return a + "jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
		}
	}
}
}
