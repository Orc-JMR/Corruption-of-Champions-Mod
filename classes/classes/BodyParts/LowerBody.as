/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class LowerBody extends BasicBodyPart{
	public var legCount:int = 2;

	override public function set type(value:int):void {
		super.type = value;
		// Reset leg count
		switch(value) {
			case LOWER_BODY_TYPE_GOO:
			case LOWER_BODY_TYPE_NAGA:
				legCount = 1;
				break;
			case LOWER_BODY_TYPE_BEE:
			case LOWER_BODY_TYPE_BUNNY:
			case LOWER_BODY_TYPE_CAT:
			case LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS:
			case LOWER_BODY_TYPE_DEMONIC_CLAWS:
			case LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS:
			case LOWER_BODY_TYPE_DOG:
			case LOWER_BODY_TYPE_DRAGON:
			case LOWER_BODY_TYPE_ECHIDNA:
			case LOWER_BODY_TYPE_FERRET:
			case LOWER_BODY_TYPE_FOX:
			case LOWER_BODY_TYPE_HARPY:
			case LOWER_BODY_TYPE_HUMAN:
			case LOWER_BODY_TYPE_KANGAROO:
			case LOWER_BODY_TYPE_LIZARD:
			case LOWER_BODY_TYPE_RACCOON:
			case LOWER_BODY_TYPE_SALAMANDER:
				legCount = 2;
				break;
			case LOWER_BODY_TYPE_CLOVEN_HOOFED:
			case LOWER_BODY_TYPE_HOOFED:
				if (legCount != 4) legCount = 2;
				break;
			case LOWER_BODY_TYPE_PONY:
				legCount = 4;
				break;
			case LOWER_BODY_TYPE_CENTAUR: // deprecated value
				legCount = 4;
				type = LOWER_BODY_TYPE_HOOFED;
				break;
			case LOWER_BODY_TYPE_DEERTAUR:
				legCount = 4;
				type = LOWER_BODY_TYPE_CLOVEN_HOOFED;
				break;
			case LOWER_BODY_TYPE_DRIDER_LOWER_BODY:
				legCount = 8;
				break;
		}
	}
	public function LowerBody(creature:Creature) {
		super(creature,LOWER_BODY_TYPE_HUMAN);
		addPublicPrimitives("legCount");
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		legCount = 2;
	}
}
}
