package classes
{
import classes.internals.SimpleSerializable;
import classes.internals.Utils;

	public class BreastRowClass extends SimpleSerializable
	{
		//constructor
		public function BreastRowClass()
		{
			addPublicPrimitives([
				"breasts","nipplesPerBreast","breastRating","lactationMultiplier","milkFullness","fuckable","fullness"
			]);
		}
		public var breasts:Number = 2;
		public var nipplesPerBreast:Number = 1;
		public var breastRating:Number = 0;
		public var lactationMultiplier:Number = 0;
		//Fullness used for lactation....if 75 or greater warning bells start going off!
		//If it reaches 100 it reduces lactation multiplier.
		public var milkFullness:Number = 0;
		public var fullness:Number = 0;
		public var fuckable:Boolean = false;
		public var nippleCocks:Boolean = false;
		
		public function validate():String
		{
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "BreastRowClass.validate", [
					"breasts", "nipplesPerBreast", "breastRating", "lactationMultiplier",
					"milkFullness", "fullness"
			]);
			return error;
		}

		override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			super.loadFromObject(o, ignoreErrors);
			if (nipplesPerBreast == 0) nipplesPerBreast = 1;
			if (lactationMultiplier < 0) lactationMultiplier = 0;
			if (breastRating < 0) breastRating = 0;
		}
	}
}