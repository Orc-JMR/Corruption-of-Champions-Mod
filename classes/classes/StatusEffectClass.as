package classes
{
	import classes.internals.SimpleSerializable;

	public class StatusEffectClass extends SimpleSerializable
	{
		//constructor
		public function StatusEffectClass(stype:StatusEffectType,value1:Number=0,value2:Number=0,value3:Number=0,value4:Number=0)
		{
			addPublicPrimitives(["value1","value2","value3","value4"]);
			this._stype = stype;
			this.value1 = value1;
			this.value2 = value2;
			this.value3 = value3;
			this.value4 = value4;
		}
		//data
		private var _stype:StatusEffectType;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		//MEMBER FUNCTIONS
		public function get stype():StatusEffectType
		{
			return _stype;
		}

		public function toString():String
		{
			return "["+_stype+","+value1+","+value2+","+value3+","+value4+"]";
		}
		override public function saveToObject(o:Object = null):Object {
			o = super.saveToObject();
			o.statusAffectName = _stype.id;
			return o;
		}
		override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			super.loadFromObject(o, ignoreErrors);

			var id:String = o.statusAffectName;

			_stype = StatusEffectType.lookupStatusEffect(id);
			if (!_stype && !ignoreErrors) {
				throw new Error("ERROR: Unknown perk id=" + id)
			}
		}
	}
}