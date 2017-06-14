package classes
{
	import classes.internals.ISerializable;
import classes.internals.SimpleSerializable;
import classes.internals.Utils;
	import mx.logging.ILogger;
	import classes.internals.LoggerFactory;

	public class VaginaClass extends SimpleSerializable
	{
		include "../../includes/appearanceDefs.as";
		public static const DEFAULT_CLIT_LENGTH:Number = 0.5;
		private static const LOGGER:ILogger = LoggerFactory.getLogger(VaginaClass);
		
		//constructor
		public function VaginaClass(vaginalWetness:Number = 1, vaginalLooseness:Number = 0, virgin:Boolean = false, clitLength:Number = DEFAULT_CLIT_LENGTH)
		{
			addPublicPrimitives([
				"type",
				"vaginalWetness",
				"vaginalLooseness",
				"fullness",
				"virgin",
				"labiaPierced",
				"labiaPShort",
				"labiaPLong",
				"clitPierced",
				"clitPShort",
				"clitPLong",
				"clitLength",
				"recoveryProgress"
			]);
			this.virgin=virgin;
			this.vaginalWetness=vaginalWetness;
			this.vaginalLooseness=vaginalLooseness;
			this.clitLength = clitLength;
			this.recoveryProgress = 0;
		}
		//data
		//Vag wetness
		public var vaginalWetness:Number = 1;
		/*Vag looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
		public var vaginalLooseness:Number = 0;
		//Type
		//0 - Normal
		//5 - Black bugvag
		public var type:int = 0;
		public var virgin:Boolean = true;
		//Used during sex to determine how full it currently is.  For multi-dick sex.
		public var fullness:Number = 0;
		public var labiaPierced:Number = 0;
		public var labiaPShort:String = "";
		public var labiaPLong:String = "";		
		public var clitPierced:Number = 0;
		public var clitPShort:String = "";
		public var clitPLong:String = "";
		public var clitLength:Number;
		public var recoveryProgress:int;

		public function validate():String
		{
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "VaginaClass.validate", [
				"vaginalWetness", "vaginalLooseness", "type",
				"fullness", "labiaPierced", "clitPierced", "clitLength", "recoveryProgress"
			]);
			if (labiaPierced) {
				if (labiaPShort == "") error += "Labia pierced but labiaPShort = ''. ";
				if (labiaPLong == "") error += "Labia pierced but labiaPLong = ''. ";
			} else {
				if (labiaPShort != "") error += "Labia not pierced but labiaPShort = '" + labiaPShort + "'. ";
				if (labiaPLong != "") error += "Labia not pierced but labiaPLong = '" + labiaPShort + "'. ";
			}
			if (clitPierced) {
				if (clitPShort == "") error += "Clit pierced but labiaPShort = ''. ";
				if (clitPLong == "") error += "Clit pierced but labiaPLong = ''. ";
			} else {
				if (clitPShort != "") error += "Clit not pierced but labiaPShort = '" + labiaPShort + "'. ";
				if (clitPLong != "") error += "Clit not pierced but labiaPLong = '" + labiaPShort + "'. ";
			}
			return error;
		}
		
		/**
		 * Wetness factor used for calculating capacity.
		 * 
		 * @return wetness factor based on wetness
		 */
		public function wetnessFactor():Number {
			return 1 + vaginalWetness / 10;
		}
		
		private function baseCapacity(bonusCapacity:Number):Number {
			return bonusCapacity + 8 * vaginalLooseness * vaginalLooseness;
		}
		
		/**
		 * The capacity of the vagina, calculated using looseness and wetness.
		 * 
		 * @param bonusCapacity extra space to add
		 * @return the total capacity, with all factors considered.
		 */
		public function capacity(bonusCapacity:Number = 0):Number {
			return baseCapacity(bonusCapacity) * wetnessFactor();
		}
		
		//TODO call this in the setter? With new value > old value check?
		/**
		 * Resets the recovery counter.
		 * The counter is used for looseness recovery over time, a reset usualy occurs when the looseness increases.
		 */
		public function resetRecoveryProgress():void {
			this.recoveryProgress = 0;
		}
		
		/**
		 * Try to stretch the vagina with the given cock area.
		 * 
		 * @param cArea the area of the cock doing the stretching
		 * @param hasFeraMilkingTwat true if the player has the given Perk
		 * @return true if the vagina was stretched
		 */
		public function stretch(cArea:Number, bonusCapacity:Number = 0, hasFeraMilkingTwat:Boolean = false):Boolean {
			var stretched:Boolean = false;
			if (!hasFeraMilkingTwat || vaginalLooseness <= VAGINA_LOOSENESS_NORMAL) {
				//cArea > capacity = autostreeeeetch.
				if (cArea >= capacity(bonusCapacity)) {
					vaginalLooseness++;
					stretched = true;
				}
				//If within top 10% of capacity, 50% stretch
				else if (cArea >= .9 * capacity(bonusCapacity) && Utils.rand(2) == 0) {
					vaginalLooseness++;
					stretched = true;
				}
				//if within 75th to 90th percentile, 25% stretch
				else if (cArea >= .75 * capacity(bonusCapacity) && Utils.rand(4) == 0) {
					vaginalLooseness++;
					stretched = true;
				}
			}
			if (vaginalLooseness > VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) vaginalLooseness = VAGINA_LOOSENESS_LEVEL_CLOWN_CAR;
			if (hasFeraMilkingTwat && vaginalLooseness > VAGINA_LOOSENESS_LOOSE) vaginalLooseness = VAGINA_LOOSENESS_LOOSE;

			if (virgin) {
				virgin = false;
			}
			
			if (stretched) {
				trace("CUNT STRETCHED TO " + (vaginalLooseness) + ".");
			}
			
			return stretched;
		}

		override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			super.loadFromObject(o, ignoreErrors);
			if(o.clitLength === undefined) {
				this.clitLength = VaginaClass.DEFAULT_CLIT_LENGTH;
				LOGGER.warn("Clit length was not loaded, setting to default({0})", this.clitLength);
			}
			if (o.labiaPierced === undefined) {
				LOGGER.warn("Labia pierced not set, resetting labia and clit data");
				this.labiaPierced = 0;
				this.labiaPShort = "";
				this.labiaPLong = "";
				this.clitPierced = 0;
				this.clitPShort = "";
				this.clitPLong = "";
				this.clitLength = VaginaClass.DEFAULT_CLIT_LENGTH;
				this.recoveryProgress = 0;
			}
			if(o.recoveryProgress === undefined) {
				this.recoveryProgress = 0;
				LOGGER.warn("Stretch counter was not loaded, setting to {0}", this.recoveryProgress);
			}
		}
	}
}
