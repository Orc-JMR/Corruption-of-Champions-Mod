/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Tail extends BodyPart {
	public static const TYPE_NONE:int           = 0;
	public static const TYPE_HORSE:int          = 1;
	public static const TYPE_DOG:int            = 2;
	public static const TYPE_DEMONIC:int        = 3;
	public static const TYPE_COW:int            = 4;
	public static const TYPE_SPIDER_ADBOMEN:int = 5;
	public static const TYPE_BEE_ABDOMEN:int    = 6;
	public static const TYPE_SHARK:int          = 7;
	public static const TYPE_CAT:int            = 8;
	public static const TYPE_LIZARD:int         = 9;
	public static const TYPE_RABBIT:int         = 10;
	public static const TYPE_HARPY:int          = 11;
	public static const TYPE_KANGAROO:int       = 12;
	public static const TYPE_FOX:int            = 13;
	public static const TYPE_DRACONIC:int       = 14;
	public static const TYPE_RACCOON:int        = 15;
	public static const TYPE_MOUSE:int          = 16;
	public static const TYPE_FERRET:int         = 17;
	public static const TYPE_BEHEMOTH:int       = 18;
	public static const TYPE_PIG:int            = 19;
	public static const TYPE_SCORPION:int       = 20;
	public static const TYPE_GOAT:int           = 21;
	public static const TYPE_RHINO:int          = 22;
	public static const TYPE_ECHIDNA:int        = 23;
	public static const TYPE_DEER:int           = 24;
	public static const TYPE_SALAMANDER:int     = 25;

	// A number of tails; legacy version used venom for counting
	public var count:int       = 0;
	//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
	public var venom:Number    = 0;
	//Tail recharge determines how fast venom/webs comes back per hour.
	public var recharge:Number = 5;

	public function Tail(creature:Creature) {
		super(creature);
	}

	public function isLong():Boolean {
		if (creature.isNaga()) return true;
		return [
					TYPE_DOG, TYPE_DEMONIC, TYPE_COW, TYPE_SHARK, TYPE_CAT, TYPE_LIZARD, TYPE_KANGAROO,
					TYPE_FOX, TYPE_DRACONIC, TYPE_RACCOON, TYPE_MOUSE, TYPE_FERRET, TYPE_BEHEMOTH, TYPE_SCORPION
				].indexOf(type) >= 0;

	}

}
}
