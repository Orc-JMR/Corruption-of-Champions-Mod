package classes
{
import classes.internals.SimpleSerializable;

	public class PerkClass extends SimpleSerializable
	{
		//constructor
		public function PerkClass(perk:PerkType,value1:Number=0,value2:Number=0,value3:Number=0,value4:Number=0)
		{
			_ptype = perk;
			this.value1 = value1;
			this.value2 = value2;
			this.value3 = value3;
			this.value4 = value4;
			addPublicPrimitives(["value1","value2","value3","value4"]);
		}
		//data
		private var _ptype:PerkType;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		//MEMBER FUNCTIONS


		public function get ptype():PerkType
		{
			return _ptype;
		}

		public function get perkName():String
		{
			return _ptype.name;
		}

		public function get perkDesc():String
		{
			return _ptype.desc(this);
		}

		public function get perkLongDesc():String
		{
			return _ptype.longDesc;
		}

		override public function saveToObject(o:Object = null):Object {
			o = super.saveToObject(o);
			o.id = _ptype.id;
			//o.perkName = ptype.id; //uncomment for backward compatibility
			//o.perkDesc = perkDesc; // uncomment for backward compatibility
			return o;
		}
		override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			super.loadFromObject(o, ignoreErrors);

			var id:String = stringOr(o.id,stringOr(o.perkName));
			// Fix saves where the Whore perk might have been malformed.
			if (id == "History: Whote") id = PerkLib.HistoryWhore.id;
			// Fix saves where the Lusty Regeneration perk might have been malformed.
			if (id == "LustyRegeneration") id = PerkLib.LustyRegeneration.id;

			_ptype = PerkType.lookupPerk(id);
			if (!_ptype && !ignoreErrors) {
				throw new Error("ERROR: Unknown perk id=" + id);
			}

			if (isNaN(value1)) value1 = 0;
			if (_ptype == PerkLib.WizardsFocus) {
				if (value1 < 0.1) value1 = 0.5;
			}
		}
	}
}